document.addEventListener("DOMContentLoaded", function() {
    const infoWrapper = document.querySelector('.info-wrapper');
    const infoText = document.querySelector('.info-text');
    let timeoutId; // To store the timeout ID
  
    infoWrapper.addEventListener('mouseover', function() {
      clearTimeout(timeoutId); // Clear any existing timeout
      infoText.style.display = 'block';
      infoText.style.opacity = '1'; // Make the text visible
    });
  
    // Add event listener to hide the text after a short delay
    infoWrapper.addEventListener('mouseleave', function() {
      timeoutId = setTimeout(function() {
        infoText.style.opacity = '0'; // Fade out the text
        setTimeout(function() {
          infoText.style.display = 'none'; // Hide the text after fade out
        }, 500); // Adjust the delay to match the transition duration
      }, 1000); // Adjust the delay to your preference
    });
  
    // Add event listener to cancel the timeout when mouse enters the info-text
    infoText.addEventListener('mouseenter', function() {
      clearTimeout(timeoutId); // Cancel the timeout
    });
  
    // Add event listener to restart the timeout when mouse leaves the info-text
    infoText.addEventListener('mouseleave', function() {
      timeoutId = setTimeout(function() {
        infoText.style.opacity = '0'; // Fade out the text
        setTimeout(function() {
          infoText.style.display = 'none'; // Hide the text after fade out
        }, 500); // Adjust the delay to match the transition duration
      }, 1000); // Adjust the delay to your preference
    });
  });
  
