function toggleProfileUpdate() {
  var profileInfo = document.getElementById('profile-info');
  var profileUpdate = document.getElementById('profile-update');
  var passwordUpdate = document.getElementById('password-update');

  if (profileInfo.style.display !== 'none') {
    profileInfo.style.display = 'none';
    profileUpdate.style.display = 'block';
    passwordUpdate.style.display = 'none';
  } else {
    profileInfo.style.display = 'block';
    profileUpdate.style.display = 'none';
    passwordUpdate.style.display = 'none';
  }
}

function togglePasswordUpdate() {
  var passwordUpdate = document.getElementById('password-update');
  var profileUpdate = document.getElementById('profile-update');
  var profileInfo = document.getElementById('profile-info');

  if (passwordUpdate.style.display !== 'none') {
    passwordUpdate.style.display = 'none';
    profileUpdate.style.display = 'none';
    profileInfo.style.display = 'block';
  } else {
    passwordUpdate.style.display = 'block';
    profileUpdate.style.display = 'none';
    profileInfo.style.display = 'none';
  }
}

function validateForm() {
  var name = document.getElementById("support-name").value;
  var email = document.getElementById("support-email").value;
  var message = document.getElementById("support-message").value;

  if (name.trim() == "") {
    alert("Lūdzu, ievadiet savu vārdu.");
    return false;
  }

  if (email.trim() == "") {
    alert("Lūdzu, ievadiet savu e-pasta adresi.");
    return false;
  }

  return true;
}
