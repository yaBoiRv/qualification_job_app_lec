document.addEventListener("DOMContentLoaded", function() {
var currentStep = 1;
showStep(currentStep);

function showStep(step) {
  var steps = document.getElementsByClassName("step");
  var topIndicators = document.querySelectorAll("#step-indicators .step-indicator");
  var bottomIndicators = document.querySelectorAll("#bottom-step-indicators .step-indicator");
  var prevBtn = document.getElementById("prevBtn");

  // Hide all steps
  for (var i = 0; i < steps.length; i++) {
    steps[i].style.display = "none";
  }

  // Remove 'current-step' class from all top indicators
  for (var i = 0; i < topIndicators.length; i++) {
    topIndicators[i].classList.remove("current-step");
  }

  // Remove 'current-step' class from all bottom indicators
  for (var i = 0; i < bottomIndicators.length; i++) {
    bottomIndicators[i].classList.remove("current-step");
  }

  // Show current step
  steps[step - 1].style.display = "block";

  // Add 'current-step' class to current top indicator
  topIndicators[step - 1].classList.add("current-step");

  // Add 'current-step' class to current bottom indicator
  bottomIndicators[step - 1].classList.add("current-step");

  // Show/hide navigation buttons
  if (step === steps.length) {
    document.getElementById("nextBtn").style.display = "none";
    document.getElementById("prevBtn").style.display = "inline";
    document.getElementById("submitBtn").style.display = "inline";
    
    var deleteExerciseBtn = document.getElementById("delete-exercise");
    if (deleteExerciseBtn) {
      deleteExerciseBtn.style.display = "inline";
    }
  } else {
    var deleteExerciseBtn = document.getElementById("delete-exercise");
    if (deleteExerciseBtn) {
      deleteExerciseBtn.style.display = "none";
    }
    
    document.getElementById("nextBtn").style.display = "inline";
    document.getElementById("submitBtn").style.display = "none";
    // Hide 'Atpakaļ' button if on first step
    prevBtn.style.display = (step === 1) ? "none" : "inline";
  }
  

  currentStep = step;
}

function nextStep() {
  if (currentStep < document.getElementsByClassName("step").length) {
      showStep(currentStep + 1);
  }
}

function prevStep() {
  if (currentStep > 1) {
      showStep(currentStep - 1);
  }
}

// Event listeners for navigation buttons
document.getElementById("nextBtn").addEventListener("click", nextStep);
document.getElementById("prevBtn").addEventListener("click", prevStep);
});
