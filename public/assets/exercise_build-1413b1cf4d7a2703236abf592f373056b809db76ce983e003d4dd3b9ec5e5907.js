document.addEventListener("DOMContentLoaded", function() {
    var canvas = document.getElementById('canvas');
    var ctx = canvas.getContext('2d');
    var canvasOffset = {x: canvas.offsetLeft, y: canvas.offsetTop};
    var dragObject = null;
    var selectedObject = null;
    var objectsOnCanvas = [];
    var isDragging = false;
    var objectCounter = 1;
    var canvasData = document.getElementById("canvasDataField").value;

    function drawObjects() {
        ctx.fillStyle = "white";
        ctx.fillRect(0, 0, canvas.width, canvas.height);
    
        objectsOnCanvas.forEach(function(obj) {
            ctx.save();
            ctx.translate(obj.x + obj.width / 2, obj.y + obj.height / 2);
            ctx.rotate(obj.angle);
            ctx.drawImage(obj.image, -obj.width / 2, -obj.height / 2, obj.width, obj.height);
            ctx.restore();
            
            if (!obj.image.alt.includes("ob-6")) {
                var textOffsetX = obj.width / 2 + 10; // Adjust this value as needed
                ctx.fillStyle = "black"; // Set the color to black for non-arrow objects
                ctx.fillText(obj.number, obj.x + obj.width / 2 + textOffsetX, obj.y + obj.height / 2);
    
                if (obj.selected) {
                    ctx.strokeStyle = "red";
                    ctx.lineWidth = 1;
                    var textWidth = ctx.measureText(obj.number).width;
                    var squareOffsetX = textOffsetX - 5; // Adjust this value as needed
                    ctx.strokeRect(obj.x + obj.width / 2 + squareOffsetX, obj.y + obj.height / 2 - 15, textWidth + 10, 20);
                }
            } else {
                // For arrows, draw a red filled circle instead of the number text
                if (obj.selected) {
                    var circleRadius = 5; // Adjust this value as needed for smaller circle
                    var circleOffsetX = obj.width / 2 + 20; // Adjust this value as needed for right-side positioning
                    ctx.beginPath();
                    ctx.arc(obj.x + obj.width / 2 + circleOffsetX, obj.y + obj.height / 2, circleRadius, 0, Math.PI * 2);
                    ctx.fillStyle = "red";
                    ctx.fill();
                    ctx.closePath();
                }
            }
        });
    }

    function clearCanva() {
        ctx.clearRect(0, 0, canvas.width, canvas.height); // Clear the objects on the canvas
        objectsOnCanvas = [];
        updateNumbering();
    }

    function initDraggableObjects() {
        document.querySelectorAll('#svg-library img').forEach(function(imgElement) {
            // Event listener for mousedown on draggable images
            imgElement.addEventListener('mousedown', function(e) {
                // Create a new object for the image being dragged
                var newObject = {
                    image: imgElement,
                    // Calculate initial position based on mouse coordinates and canvas offset
                    x: canvas.width / 2 - imgElement.width / 2,
                    y: canvas.height / 2 - imgElement.height / 2,
                    width: imgElement.width,
                    height: imgElement.height,
                    angle: 0
                };
                if (!imgElement.alt.includes("ob-6")) {
                    newObject.number = objectCounter++; // Increment object counter
                }
                objectsOnCanvas.push(newObject);
                selectedObject = newObject;
                // Redraw objects on the canvas
                drawObjects();
            });
        });
    }
    
    canvas.addEventListener('mousedown', function(e) {
        var rect = canvas.getBoundingClientRect();
        var mouseX = (e.clientX - rect.left) * (canvas.width / rect.width);
        var mouseY = (e.clientY - rect.top) * (canvas.height / rect.height);

        dragObject = null;
        selectedObject = null;
        // Iterate through objects on canvas to check for selection
        for (var i = objectsOnCanvas.length - 1; i >= 0; i--) {
            var obj = objectsOnCanvas[i];
            // Check if mouse pointer is within the bounding box of the object
            if (mouseX > obj.x && mouseX < obj.x + obj.width && mouseY > obj.y && mouseY < obj.y + obj.height) {
                dragObject = obj; // Set the object as the one being dragged
                isDragging = true;
                // Calculate offset from mouse pointer to object position
                dragObject.offsetX = mouseX - obj.x;
                dragObject.offsetY = mouseY - obj.y;
                break;
            }
        }
        if (!dragObject) {
            // Deselect all objects if no object is being dragged
            objectsOnCanvas.forEach(function(obj) {
                obj.selected = false;
            });
        }
    });

    canvas.addEventListener('mousemove', function(e) {
        if (isDragging && dragObject) {
            var rect = canvas.getBoundingClientRect();
            // Update object position based on mouse movement
            var mouseX = (e.clientX - rect.left) * (canvas.width / rect.width);
            var mouseY = (e.clientY - rect.top) * (canvas.height / rect.height);
            dragObject.x = mouseX - dragObject.offsetX;
            dragObject.y = mouseY - dragObject.offsetY;
            // Redraw objects on the canvas
            drawObjects();
        }
    });

    canvas.addEventListener('mouseup', function(e) {
        isDragging = false;
        dragObject = null;
    });

    canvas.addEventListener('click', function(e) {
        var rect = canvas.getBoundingClientRect();
        var mouseX = (e.clientX - rect.left) * (canvas.width / rect.width);
        var mouseY = (e.clientY - rect.top) * (canvas.height / rect.height);

        selectedObject = null;
        // Iterate through objects on canvas to check for selection
        objectsOnCanvas.forEach(function(obj) {
            // Check if mouse pointer is within the bounding box of the object
            if (mouseX > obj.x && mouseX < obj.x + obj.width && mouseY > obj.y && mouseY < obj.y + obj.height) {
                obj.selected = true; // Set the object as selected
                selectedObject = obj;
            } else {
                obj.selected = false;
            }
        });
        // Redraw objects on the canvas
        drawObjects();
    });

    document.getElementById('rotateBtnRight').addEventListener('click', function(e) {
        e.preventDefault(); // Prevent form submission
        if (selectedObject) {
            selectedObject.angle += Math.PI / 15;
            // Redraw objects on the canvas
            drawObjects();
        }
    });

    document.getElementById('rotateBtnLeft').addEventListener('click', function(e) {
        e.preventDefault(); // Prevent form submission
        if (selectedObject) {
            selectedObject.angle += Math.PI / -15;
            // Redraw objects on the canvas
            drawObjects();
        }
    });

    document.getElementById('removeBtn').addEventListener('click', function(e) {
        e.preventDefault(); // Prevent form submission
        if (selectedObject) {
            var indexToRemove = objectsOnCanvas.indexOf(selectedObject);
            if (indexToRemove !== -1) {
                objectsOnCanvas.splice(indexToRemove, 1);
                updateNumbering(); // Update object numbering after removal
                selectedObject = null;
                // Redraw objects on the canvas
                drawObjects();
            }
        }
    });

    document.addEventListener('keydown', function(e) {
        if (selectedObject && (e.key === 'Delete' || e.key === 'Backspace')) {
            var indexToRemove = objectsOnCanvas.indexOf(selectedObject);
            if (indexToRemove !== -1) {
                objectsOnCanvas.splice(indexToRemove, 1);
                updateNumbering(); // Update object numbering after removal
                selectedObject = null;
                // Redraw objects on the canvas
                drawObjects();
            }
        }
    });

    function updateNumbering() {
        // Update object numbering after removal
        objectsOnCanvas.forEach(function(obj, index) {
            obj.number = index + 1;
        });
        objectCounter = objectsOnCanvas.length + 1;
    }

    function saveCanvasData() {
        // Convert the image elements to their alt attributes for serialization
        var objectsToSave = objectsOnCanvas.map(function(obj) {
            return {
                imageAlt: obj.image.alt,
                x: obj.x,
                y: obj.y,
                width: obj.width,
                height: obj.height,
                angle: obj.angle,
                number: obj.number,
                offsetX: obj.offsetX,
                offsetY: obj.offsetY,
                selected: obj.selected
            };
        });
        var canvasData = JSON.stringify(objectsToSave);

        document.getElementById("canvasDataField").value = canvasData;
        canvaToImage();
        document.getElementById("exercise_form").submit();
    }

    function loadCanvasData(canvasData) {
        // Parse JSON string to objects
        var parsedData = JSON.parse(canvasData);
        var imagesLoaded = 0;
        var totalImages = parsedData.length;
     
        // Function to check if all images are loaded
        function checkAllImagesLoaded() {
            imagesLoaded++;
            if (imagesLoaded === totalImages) {
                // Once all images are loaded, draw them onto the canvas
                drawObjects();
            }
        }
    
        // Clear existing objects on the canvas
        clearCanva();
    
        // Map the parsed data to create objects with image elements
        parsedData.forEach(function(objData) {
            // Find the image element based on the alt attribute
            var imgElement = document.querySelector('#svg-library img[alt="' + objData.imageAlt + '"]');
            var newObj = {
                image: imgElement,
                x: objData.x,
                y: objData.y,
                width: objData.width,
                height: objData.height,
                angle: objData.angle,
                number: objData.number,
                offsetX: objData.offsetX,
                offsetY: objData.offsetY,
                selected: objData.selected
            };
    
            // Increment imagesLoaded counter when image is loaded
            imgElement.onload = checkAllImagesLoaded;
    
            objectsOnCanvas.push(newObj);
        });
    
        // If no images need to be loaded, draw objects immediately
        if (totalImages === 0) {
            drawObjects();
        }
    
        objectCounter = Math.max(...objectsOnCanvas.map(obj => obj.number)) + 1;
    }

    function canvaToImage(){
        objectsOnCanvas.forEach(function(obj) {
            obj.selected = false;
        });
    
        // Redraw objects on the canvas
        drawObjects();
        var canvasDataUrl = canvas.toDataURL('image/png', 1);
        var canvasImageField = document.getElementById('canvasImageField');
        canvasImageField.value = canvasDataUrl;
    }

    document.getElementById('submitBtn').addEventListener('click', function() {
        saveCanvasData();
    });

    document.getElementById('clearBtn').addEventListener('click', function(e) {
        e.preventDefault();
        clearCanva(); 
    });

    if (canvasData) {
        loadCanvasData(canvasData);
        drawObjects();
    }
    initDraggableObjects();

});
