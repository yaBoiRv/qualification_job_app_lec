function openPopup(element) {
    var smallImage = element.parentElement.querySelector(".small-image");
    var fullImage = element.parentElement.parentElement.querySelector(".full-image");
    var popupContainer = element.parentElement.parentElement.querySelector(".popup-container");

    fullImage.src = smallImage.src;
    popupContainer.style.display = "flex";
  }

  function closePopup(element) {
    var popupContainer = element.parentElement.parentElement;
    popupContainer.style.display = "none";
  }

  function printImage(element) {
    var fullImage = element.parentElement.parentElement.querySelector(".full-image");
    var popupWindow = window.open("");
    popupWindow.document.write('<img src="' + fullImage.src + '" style="width: 100%;">');
    popupWindow.document.close();
    popupWindow.print();
  }

  function downloadImage(element) {
    var fullImage = element.parentElement.parentElement.querySelector(".full-image");
    if (fullImage) {
            var exerciseName = element.closest('.popup-content').dataset.exerciseName;
            console.log(exerciseName)
            var imageName = exerciseName.toLowerCase().replace(/\s+/g, '_');
            var link = document.createElement("a");
            link.href = fullImage.src;
            link.download = imageName + ".png"; // Set the image name with a .png extension
            link.click();
    } else {
        console.error("Full image element not found.");
    }
}

function showInfoBox(event, exerciseId) {
  var infoBoxContent = document.getElementById('info-box-content-' + exerciseId);
  
  // Position the info-box-content relative to the cursor position
  infoBoxContent.style.top = (event.clientY + 10) + 'px'; // Offset by 10 pixels to prevent overlap
  infoBoxContent.style.left = (event.clientX - (infoBoxContent.offsetWidth / 2)) + 'px';
  
  // Show the info-box-content
  infoBoxContent.classList.remove('hidden');
}

function hideInfoBox(exerciseId) {
  var infoBoxContent = document.getElementById('info-box-content-' + exerciseId);
  
  // Hide the info-box-content
  infoBoxContent.classList.add('hidden');
}

function toggleDescription(textId) {
  var text = document.getElementById(textId);
  var button = text.nextElementSibling;

  text.classList.toggle("show-full-text");
  button.innerText = text.classList.contains("show-full-text") ? "Rādīt mazāk" : "Rādīt vairāk";

  // Adjust height to fit container
  if (text.classList.contains("show-full-text")) {
    text.style.maxHeight = "none";
  } else {
    text.style.maxHeight = "3em"; // Adjust as needed
  }
}


;
