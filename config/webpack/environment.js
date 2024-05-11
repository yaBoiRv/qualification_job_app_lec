const { environment } = require('@rails/webpacker')

environment.config.merge({
    entry: {
      application: './app/javascript/application.js',  // Adjust as needed
    },
  })
  
module.exports = environment
