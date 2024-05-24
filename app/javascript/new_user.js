document.addEventListener("DOMContentLoaded", function() {
  var input = document.getElementById('avatar-input');
  var cropper;
  var croppedImageDataURL;

  input.addEventListener('change', function(e) {
    var file = e.target.files[0];
    var reader = new FileReader();

    reader.onload = function (e) {
      var image = new Image();
      image.src = e.target.result;
      image.onload = function() {
        // Show the image in the popup box
        document.getElementById('previewImage').src = e.target.result;
        document.getElementById('imagePopup').classList.remove('hidden');
        // Initialize Cropper.js on the preview image
        cropper = new Cropper(document.getElementById('previewImage'), {
          aspectRatio: 1, // Set aspect ratio for square avatar
          viewMode: 1, // Restrict the crop box to fit within the container
          autoCropArea: 1 // Automatically create a crop box that covers the entire image
        });
      };
    };

    reader.readAsDataURL(file);
  });

  // Event listener for the crop button
  document.getElementById('cropButton').addEventListener('click', function() {
    // Get the cropped data as a Data URL
    croppedImageDataURL = cropper.getCroppedCanvas().toDataURL('image/png');
    // You can do something with the cropped data here, like storing it in a hidden input field
    document.getElementById('croppedImageData').value = croppedImageDataURL;
    // Close the popup box
    document.getElementById('imagePopup').classList.add('hidden');
    // Optional: Show cropped image somewhere on the page
    // document.getElementById('croppedPreview').src = croppedImageDataURL;
  });
});