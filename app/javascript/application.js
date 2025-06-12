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



document.addEventListener('DOMContentLoaded', () => {
  // Fonction pour cacher les alertes après 5 secondes (5000 ms)
  setTimeout(() => {
    const notice = document.getElementById('flash-notice');
    const alert = document.getElementById('flash-alert');

    if (notice) {
      notice.style.transition = "opacity 0.5s ease";
      notice.style.opacity = 0;
      setTimeout(() => notice.remove(), 500); // Supprime le div après la transition
    }

    if (alert) {
      alert.style.transition = "opacity 0.5s ease";
      alert.style.opacity = 0;
      setTimeout(() => alert.remove(), 500);
    }
  }, 5000); // 5 secondes avant de disparaître
});
