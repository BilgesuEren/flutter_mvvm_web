'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/assets/package.svg": "9fb1e1a2271e934cc8af2fc4bcb1aeb9",
"assets/assets/paymentProcess.svg": "d0cc9c0dfd33a3a63f38e9b446d11b59",
"assets/assets/notsecure.svg": "afc11c45de06aa84b8055e23eacc4b19",
"assets/assets/trolley.svg": "e47d50b23cb28b515bb202fe0457e990",
"assets/assets/expand_48.svg": "fc7f76250c2303b933a47946620d0947",
"assets/assets/menu.svg": "240eb74b5abb06002ad28c961b1c6296",
"assets/assets/store.svg": "25c3c31f64d7e65b8bfd2f9d793be7e7",
"assets/assets/NoSelection.svg": "d41d8cd98f00b204e9800998ecf8427e",
"assets/assets/close.svg": "8a46b92e3ee6378a43301e1d5a77b528",
"assets/assets/calendar.svg": "dd8a5372af4b2ea403330d49f4b27a22",
"assets/assets/pallet.svg": "a6ba2bb11c8afcf2bd846e29bdaee0e9",
"assets/assets/list.svg": "99d8b0a779f2e0b84d9c0d0091f54d56",
"assets/assets/warehouse.svg": "486ee9cf735a30171c48b144fa038919",
"assets/assets/pending2.svg": "6ad7946336a93c2887bf61c1f7b8c847",
"assets/assets/DBS.svg": "51ca1a7c90cfa80402d171ab0b995c1f",
"assets/assets/images/product_image.jpg": "eb5cdd64c0c328a599656b2959dd4f70",
"assets/assets/images/header_white_logo.png": "558cf1c517302095e2036b801ee9604f",
"assets/assets/add.svg": "01c804c7f5ed6f16a9b686ae6f21c25a",
"assets/assets/checkboxSelected.svg": "a92aa1be6a6f621b12d92da80311102c",
"assets/assets/scrap.svg": "ab8ad7ab4f6a09ce61e018310c900d0c",
"assets/assets/order.svg": "4c8f0d508b3f6795e14e44c8c78f10d6",
"assets/assets/exportNotes.svg": "518d75e3457f21ffec2c137f1441dde4",
"assets/assets/conveyor.svg": "b146bea8f75e9bcea5201f212f810d3e",
"assets/assets/proposal.svg": "0e0f0ab797ac6e77dc75e1958492aff7",
"assets/assets/checkbox.svg": "7fd8eecabde43caf33f97c15de3f7c07",
"assets/assets/logo.png": "fbbe4e2d571216e3d0231c61bba61360",
"assets/assets/newMessage.svg": "471816a436e6a28af19b34b9d43a1c31",
"assets/assets/attach.svg": "8f79d00900e8faf6bf8755c4e8996cac",
"assets/assets/invoice.svg": "7982413889288364002e0fd978687e39",
"assets/assets/flutter_i18n/en.yaml": "76a6338e4ac5fa0371351a3c07a51956",
"assets/assets/flutter_i18n/tr.yaml": "a941106f4bfa5b6a6193fb56278804b2",
"assets/assets/alert.svg": "edec881258ef8cf184630ecf31d90dab",
"assets/assets/shipment.svg": "514021dff72c54313bcb22360cfc96bb",
"assets/assets/paid.svg": "29a3de401735a5e469cc2a3e14e7af23",
"assets/assets/flare.svg": "6191f773c350fc4785032bee8bcea44b",
"assets/assets/home.svg": "43d44e71156fab3b0e5dc1bb269719fe",
"assets/assets/pending.svg": "3b531104d74f9babf02d260b00623033",
"assets/AssetManifest.json": "d0ba556e1ac698d1dcf212401bcffeda",
"assets/NOTICES": "28571f141e96f08ee5415c180152dd81",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"version.json": "ccca65c8603f6b34de75a49db6b5e7c5",
"manifest.json": "36b4042fc254b3a843ff2f713204843a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"index.html": "40900e65d1290848d064c7a4c4e8a75d",
"/": "40900e65d1290848d064c7a4c4e8a75d",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"main.dart.js": "01b54d2395cb73a42dca17f782bacafc",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
