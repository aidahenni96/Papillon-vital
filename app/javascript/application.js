// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import * as ActiveStorage from "@rails/activestorage"
Rails.start()

import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "bootstrap/dist/css/bootstrap.min.css"
import Rails from "@rails/ujs"
import "@rails/request.js"
Rails.start()

ActiveStorage.start()
Rails.start()

if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/service-worker.js')
    .then(reg => console.log('Service Worker registered.', reg))
    .catch(err => console.error('Service Worker registration failed:', err));
}

