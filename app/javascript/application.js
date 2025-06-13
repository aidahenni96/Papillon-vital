// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import * as ActiveStorage from "@rails/activestorage"
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import "@rails/request.js"

ActiveStorage.start()

// Vérifie et enregistre le Service Worker
if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/service-worker.js')
    .then(reg => console.log('Service Worker registered.', reg))
    .catch(err => console.error('Service Worker registration failed:', err));
}



