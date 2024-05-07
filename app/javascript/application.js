// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// app/javascript/packs/application.js    
//= require jquery
//= require jquery_ujs

document.addEventListener('DOMContentLoaded', function() {
setTimeout(function() {
        var noticeElement = document.getElementById('notice');
        var errorElement = document.getElementById('error');
        
        if (noticeElement) {
          noticeElement.style.display = 'none';
        }
        
        if (errorElement) {
          errorElement.style.display = 'none';
        }
      }, 3000);
});
