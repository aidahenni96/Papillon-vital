// service-worker.js

// Installer le service worker et mettre en cache les ressources nécessaires
self.addEventListener('install', event => {
  console.log('[Service Worker] Install');
  // On peut pré-cacher ici si besoin, par exemple :
  // event.waitUntil(
  //   caches.open('static-v1').then(cache => cache.addAll(['/','/styles.css','/script.js']))
  // );
});

// Activer le service worker
self.addEventListener('activate', event => {
  console.log('[Service Worker] Activate');
  // Ici tu peux gérer le nettoyage de caches obsolètes si tu en utilises
});

// Intercepter les requêtes réseau et renvoyer les ressources en cache si disponibles
self.addEventListener('fetch', event => {
  console.log('[Service Worker] Fetch', event.request.url);
  event.respondWith(
    caches.match(event.request)
      .then(response => response || fetch(event.request))
  );
});
