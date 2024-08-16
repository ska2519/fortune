'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "f29322c54e9bff5349b40fcc5aa9b872",
"version.json": "a0799a5ba4d564dc1b92a57a72113748",
"index.html": "1e4c8e4af017a350e49ca7d94c3ad0cf",
"/": "1e4c8e4af017a350e49ca7d94c3ad0cf",
"main.dart.js": "1d5e97b74ae987a8eb030288afffb283",
"ads.txt": "aa2696e289243f6bcba91d55f734bff3",
"flutter.js": "f31737fb005cd3a3c6bd9355efd33061",
"favicon.png": "dd23d41dc0f38a6d620e5da9d4571ae6",
"icons/Icon-192.png": "e157da37697cca81bac072f0d828756f",
"icons/Icon-maskable-192.png": "e157da37697cca81bac072f0d828756f",
"icons/Icon-maskable-512.png": "7aa212b6d6694f81a8496372dafdb169",
"icons/Icon-512.png": "7aa212b6d6694f81a8496372dafdb169",
"style.css": "f8351e56acf3ee4230ea4441c98f5de4",
"manifest.json": "4fd2c519d3728360d590858181b0afbc",
"assets/AssetManifest.json": "eda5758aae593a76288fdc69f15fae55",
"assets/NOTICES": "79d41e1e38423e4a99e87da34c7dcfff",
"assets/FontManifest.json": "95d92eb1d2c4aa0f609467a421f47b52",
"assets/AssetManifest.bin.json": "49c2ba5ed15e7d06d1ec7a473546c799",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/packages/flutter_image_compress_web/assets/pica.min.js": "6208ed6419908c4b04382adc8a3053a2",
"assets/packages/flutter_dropzone_web/assets/flutter_dropzone.js": "5530dc96a013849f2739b2393d1b8102",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "6d5bfa208e8d84dde39f82bca63d76a1",
"assets/fonts/MaterialIcons-Regular.otf": "2bfd111faed3a7839a4c5012ca4c190a",
"assets/assets/flags/sv.webp": "c6e1ceba5fa93ed6cc3f07d42c837db8",
"assets/assets/flags/th.webp": "3cb1061ee128f6bc660e7382586e596c",
"assets/assets/flags/ar.webp": "c0532ea567dad4747e9abea827f47170",
"assets/assets/flags/es.webp": "4896a552a8919e1f10742eaddcc61ecb",
"assets/assets/flags/vi.webp": "b745ae856389de015c8c70f5f3a74eba",
"assets/assets/flags/fa.webp": "faf9f4bcaa528f087d4c3152d98e1d86",
"assets/assets/flags/id.webp": "f335a72206e8553ef1ffb7839e7e9480",
"assets/assets/flags/no.webp": "db24b43300b0d8f7875edad870ca262a",
"assets/assets/flags/hi.webp": "931f29ce9b3b4c53fcb694cf333ecc72",
"assets/assets/flags/ko.webp": "9dc39bb18cdf275eb173226e31518c98",
"assets/assets/flags/fr.webp": "69e4e6ea3fc06483e4df20438929d779",
"assets/assets/flags/pt.webp": "8dd2f314ec798d00e5c2d8037a179d17",
"assets/assets/flags/en.webp": "790a7645a8ea74628914abe048b8c471",
"assets/assets/flags/it.webp": "74833f11a3c3fae2b2d8eb80b2a782b6",
"assets/assets/flags/uk.webp": "e701b69e765052c419c37022cf7fc26b",
"assets/assets/flags/pl.webp": "472b5f9259914c09380020f524482cad",
"assets/assets/flags/ru.webp": "d988005bb6fa0e4ee3b2ad85810d23c3",
"assets/assets/flags/de.webp": "a0aeb73d3f24a72e5b07a8f8926ac281",
"assets/assets/flags/cn.webp": "69e441a836daa513d6ff4fdf7fcd8112",
"assets/assets/flags/ur.webp": "c872a804fbb616ba9205ec27b8d93bc0",
"assets/assets/flags/ms.webp": "b1bdd2d142de5724879d249527815c75",
"assets/assets/flags/nl.webp": "5b1928a2ec87f457974b14e8090a780f",
"assets/assets/flags/ja.webp": "57543493486685feb5c9adb9a0ca5ef2",
"assets/assets/flags/tr.webp": "f76cb7ea5a6af89f255741642050ed98",
"assets/assets/flags/bn.webp": "5b84fb6e7edd94bc0ad44c81aa15b227",
"assets/assets/app_icon.png": "93c70e25cacf80e6abb96f365d6a9602",
"assets/assets/tellers/teller_2.webp": "685d07065377b72d017d7d599f337b51",
"assets/assets/tellers/teller_3.webp": "7c5228f1ea813377412db9a7bdea9d79",
"assets/assets/tellers/teller_1.webp": "ce0eb7552602a0fb09607254158b9759",
"assets/assets/icons/furitshop_app_icon.png": "0202c5bab798b96d9989eb583745ee30",
"assets/assets/fonts/NanumSquareNeoOTF-Bd.otf": "ac2c6dd4698f65fb1e799efc81b8d77a",
"assets/assets/fonts/NanumSquareNeoOTF-Rg.otf": "4ba733bc5941db853a333f11ee65ba01",
"assets/assets/faces/prince-akachi-J1OScm_uHUQ-unsplash.webp": "3616284dd7d47e00f1bcb137035a9fd9",
"assets/assets/faces/danie-franco-A6O7pgc7vHg-unsplash.webp": "429c27430eebae925b79ab4deed79880",
"assets/assets/faces/jack-finnigan-rriAI0nhcbc-unsplash.webp": "6ea9552434420d0202d54ca9138410bf",
"assets/assets/faces/aiony-haust-3TLl_97HNJo-unsplash.webp": "579f3ba4194397c7064263112b04aeb6",
"assets/assets/faces/erik-lucatero-d2MSDujJl2g-unsplash.webp": "1e43d1e502519100dd409edea2d28bb1",
"assets/assets/faces/gabriel-silverio-u3WmDyKGsrY-unsplash.webp": "bfc858d3db5a04e0ba0fb604e2c68dbb",
"assets/assets/faces/jurica-koletic-7YVZYZeITc8-unsplash.webp": "9a22452054cf758263907a122554bbae",
"assets/assets/faces/paola-aguilar-LkQHGSVzfsk-unsplash.webp": "7b18695fc7cbd1cbf71f2c4b455acd17",
"canvaskit/skwasm.js": "9fa2ffe90a40d062dd2343c7b84caf01",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "87325e67bf77a9b483250e1fb1b54677",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "5fda3f1af7d6433d53b24083e2219fa0",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
