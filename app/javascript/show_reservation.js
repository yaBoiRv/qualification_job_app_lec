document.addEventListener("DOMContentLoaded", function() {
    const infoWrapper = document.querySelector('.info-wrapper');
    const infoText = document.querySelector('.info-text');
    let timeoutId; // To store the timeout ID
  
    infoWrapper.addEventListener('mouseover', function() {
      clearTimeout(timeoutId);
      infoText.style.display = 'block';
      infoText.style.opacity = '1';
    });
  
    // Add event listener to hide the text after a short delay
    infoWrapper.addEventListener('mouseleave', function() {
      timeoutId = setTimeout(function() {
        infoText.style.opacity = '0';
        setTimeout(function() {
          infoText.style.display = 'none';
        }, 500);
      }, 1000);
    });
  
    // Add event listener to cancel the timeout when mouse enters the info-text
    infoText.addEventListener('mouseenter', function() {
      clearTimeout(timeoutId);
    });
  
    // Add event listener to restart the timeout when mouse leaves the info-text
    infoText.addEventListener('mouseleave', function() {
      timeoutId = setTimeout(function() {
        infoText.style.opacity = '0';
        setTimeout(function() {
          infoText.style.display = 'none';
        }, 500);
      }, 1000);
    });
  });
  