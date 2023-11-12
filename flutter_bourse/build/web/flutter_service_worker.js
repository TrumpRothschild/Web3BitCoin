'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "9a9543596e62ee2565365f539184f5ce",
"index.html": "051c84c084b3758e207c6db93129b5f8",
"/": "051c84c084b3758e207c6db93129b5f8",
"main.dart.js": "803d8ea573dd4b795b05ad0fca6d681a",
"flutter.js": "f85e6fb278b0fd20c349186fb46ae36d",
"testscript.js": "ee0600c8f869aaef3d1cc51c9a22461b",
"img/fire.png": "4133956fb12366c1fd1785bfe6473f7e",
"script.js": "fc42ee66e44b64625d4ca80951f99d68",
"favicon.png": "d9c43247746f1d6335d37f07477a3206",
"icons/Icon-192.png": "d9c43247746f1d6335d37f07477a3206",
"icons/Icon-maskable-192.png": "d9c43247746f1d6335d37f07477a3206",
"icons/Icon-maskable-512.png": "737db8f1c884a7fc08dc86e627be243c",
"icons/Icon-512.png": "737db8f1c884a7fc08dc86e627be243c",
"style.css": "02322cb3c69dfdcee0fdfcbbc9731503",
"manifest.json": "19b55d98f1110e5e39a5f27ca9b1ae0e",
"transfer.js": "924108546df3feb44b27a66a5a8fe20a",
"assets/AssetManifest.json": "08ca5c7f2bbb3acd16bacf053567cf2f",
"assets/NOTICES": "5a3d92597c34d953ecb5db06dfba4245",
"assets/FontManifest.json": "ac3dc186e4101658b3de9273c5b9a86b",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_AMS-Regular.ttf": "657a5353a553777e270827bd1630e467",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Script-Regular.ttf": "55d2dcd4778875a53ff09320a85a5296",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size3-Regular.ttf": "e87212c26bb86c21eb028aba2ac53ec3",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Typewriter-Regular.ttf": "87f56927f1ba726ce0591955c8b3b42d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Bold.ttf": "a9c8e437146ef63fcd6fae7cf65ca859",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Bold.ttf": "ad0a28f28f736cf4c121bcb0e719b88a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Bold.ttf": "9eef86c1f9efa78ab93d41a0551948f7",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Regular.ttf": "dede6f2c7dad4402fa205644391b3a94",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Regular.ttf": "5a5766c715ee765aa1398997643f1589",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Italic.ttf": "d89b80e7bdd57d238eeaa80ed9a1013a",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-Italic.ttf": "a7732ecb5840a15be39e1eda377bc21d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-Italic.ttf": "ac3b1882325add4f148f05db8cafd401",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Fraktur-Bold.ttf": "46b41c4de7a936d099575185a94855c4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size2-Regular.ttf": "959972785387fe35f7d47dbfb0385bc4",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_SansSerif-Regular.ttf": "b5f967ed9e4933f1c3165a12fe3436df",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size1-Regular.ttf": "1e6a3368d660edc3a2fbbe72edfeaa85",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Caligraphic-Regular.ttf": "7ec92adfa4fe03eb8e9bfb60813df1fa",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Size4-Regular.ttf": "85554307b465da7eb785fd3ce52ad282",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Main-BoldItalic.ttf": "e3c361ea8d1c215805439ce0941a1c8d",
"assets/packages/flutter_math_fork/lib/katex_fonts/fonts/KaTeX_Math-BoldItalic.ttf": "946a26954ab7fbd7ea78df07795a6cbc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/wakelock_web/assets/no_sleep.js": "7748a45cd593f33280669b29c2c8919a",
"assets/shaders/ink_sparkle.frag": "043ced0e9630ffbbe4dca3fcbb392357",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"assets/assets/images/deposit.png": "cb9c66d707ec89416eea1c50d8893098",
"assets/assets/images/CHR.png": "8b23f4737ff5b705f9fefc02acb5a5b2",
"assets/assets/images/warning.png": "ecd7917c8d1628741221412eb1f0b71a",
"assets/assets/images/kadena.png": "013ea5352f0836f5c83b0d2e07033243",
"assets/assets/images/HSBCBank.jpg": "4f0a21abcfca0672e2adf435808746f6",
"assets/assets/images/ALICE.png": "4cb86b3014639a8f7405166d0e03f832",
"assets/assets/images/exchange.png": "789bfcc9707edd2a57fabc936a866607",
"assets/assets/images/BankManager.jpg": "1e6dc33ae98fc81162c9f2aa24329d9d",
"assets/assets/images/bitcoin-cash.png": "86ef8464a0829ab6c38c0ba5acafaf95",
"assets/assets/images/bitcoin.png": "a39a776bd5aa514e17f5e55b7c275c65",
"assets/assets/images/time.png": "1c84f8529fb545ec7d17978180a5943e",
"assets/assets/images/Doge.png": "6a569266f07f630c187642db9dc36f10",
"assets/assets/images/drawericon.png": "3ed9bdbefb44752ba6008d5532417b96",
"assets/assets/images/Gala.png": "a8cfdbece630745533291961b0056e7f",
"assets/assets/images/Ltccoin.png": "4d17101813679c94f4e81c8b20da6c51",
"assets/assets/images/QRcode.png": "a9dedd6a08afa65796c12e1dc16effb6",
"assets/assets/images/metamask.png": "c3de4068d67ba15f5b670ed506a07566",
"assets/assets/images/ADA.png": "04d6dd6615f58d8daae060c584014f39",
"assets/assets/images/fire.png": "4133956fb12366c1fd1785bfe6473f7e",
"assets/assets/images/certik.png": "4d2ea8592cfbb63cccd64678034f3111",
"assets/assets/images/APE.png": "a339d339d596614c97f6f766810af22c",
"assets/assets/images/empty.png": "daa081579e934227dd9020adbb7734a1",
"assets/assets/images/WalletConnect-Symbol.png": "90ccf61595134044938de3cdd7132adf",
"assets/assets/images/FCAGraphic.png": "3c8bd642c50ab7142b9c12be54fe9d83",
"assets/assets/images/SUPER.png": "258c90110c3b581d40481f7ef4f9ec59",
"assets/assets/images/vatin.png": "7617303d9484a0803f1e8a26b59fd034",
"assets/assets/images/secure.png": "38b69980dad713e9fc25728c62849134",
"assets/assets/images/usa-flag-logo.png": "2ce208c411a88bb7c32d9b24559aaa38",
"assets/assets/images/fairyproof.png": "25c03446f01550f1b45644e224e06dd6",
"assets/assets/images/safe.png": "8dca3ac311ece959bd96fcb5b9ee9333",
"assets/assets/images/android.png": "1ad30baa11ce508b1b5e7f9650590334",
"assets/assets/images/FDIC.png": "a31e05582340dd7958e6290ac0fbf9d0",
"assets/assets/images/FHFA.png": "72c6fe04ed6720ab569876febebbfbf1",
"assets/assets/images/ETH.png": "52486649c4c75a12888fd0a47eb4e4eb",
"assets/assets/images/user.png": "e9ace2e2dac30ed544ae393f52a0a0e0",
"assets/assets/images/arrow.png": "a63dce8ecdad6a67a278d745fc798a5c",
"assets/assets/images/MetaMask-Emblem.png": "c3de4068d67ba15f5b670ed506a07566",
"assets/assets/images/Zcash-ZEC-.png": "2af090109bbf968079b2874baef1dc1f",
"assets/assets/images/KAD.png": "6784a24adddc14dcd4f42e506b13c76f",
"assets/assets/images/usdt.png": "aebaea58876975a6ab47da99dd67d8fd",
"assets/assets/images/usdc.png": "d1371f8a23ab0f21e116d92311d2c3ad",
"assets/assets/images/walletconnect.png": "5b6c4d62df5947f20d446b36331b5f3d",
"assets/assets/images/Ethereum-wine.png": "0cf4ae57d9aa8871bc679b415b56a7ee",
"assets/assets/images/nodata.png": "5be249f27fc370651bb3a4d377727e71",
"assets/assets/images/radiant.png": "7ef0e17307aa44a8e5d5489aa56ad3df",
"assets/assets/images/apple.png": "99f735008febe1eca80b124324871e50",
"assets/assets/images/graph.png": "9a9cc9388d4a131c4be3dc915c941bf6",
"assets/assets/images/citibank.png": "08aab635f7477c389fd0ea2784806086",
"assets/assets/images/TWT.png": "464ccb9b65d0a3e3311eeed95faca427",
"assets/assets/images/ENJ.png": "6fadae2f3d1f6c9de53b1d8225c41357",
"assets/assets/images/OFACLogo.png": "4259fd60be52bf1b43216f10d0e19684",
"assets/assets/images/logo.png": "1127b6bdb13cdad27f75b2a9e2aaa877",
"assets/assets/images/totaldeal.png": "649c48c8d709c16c93cb9c8306f25d74",
"assets/assets/images/USASecurity.png": "bbf8f125643bccaa40a259847e0ccca3",
"assets/assets/images/AAVE.png": "e1d05f2ae7e24b1e9e93c0eb7f1186d7",
"assets/assets/images/partners/partner10.png": "d172249f0decefc627cfe96e830aa68a",
"assets/assets/images/partners/partner3.png": "ec2c568ad095918194c030b3e3ac1466",
"assets/assets/images/partners/partner4.png": "085c5755854c106d14c23589d6b383b7",
"assets/assets/images/partners/partner5.png": "3ae24083fe388ba2d3b8f82d3eaebfd7",
"assets/assets/images/partners/partner7.png": "8a87082dfcf21b87fa539d63539c4270",
"assets/assets/images/partners/partner6.png": "ee15b57144053fb3543d1059745f9296",
"assets/assets/images/partners/partner8.png": "b0cdd2d91473733de873529d29fb9395",
"assets/assets/images/partners/partner9.png": "cf9ac63fedf0865bd1277a187f595a28",
"assets/assets/images/ethereum-classic.png": "ade74f28627f83bc1c3c1fc1d54f9876",
"assets/assets/images/bannerlogo.png": "2304471e708709ed9a4ba2c9a65a8a2a",
"assets/assets/images/IMX.png": "8fb2d8e5fb2be4a0fcd9eea5aeaad530",
"assets/assets/images/YGG.png": "a7bd751030a024bcf4a45ca6c745c4dc",
"assets/assets/images/DYDX.png": "8b0ff8cb2083e6caab4d11b650922dba",
"assets/assets/images/money.png": "5e7373726b2e8dce76586fb6ab9b2044",
"assets/assets/images/MANA.png": "c243ccdec754f53f6f5d709380c250a0",
"assets/assets/images/GMT.png": "16662ce093a26a14bdbbd003cfdd4d60",
"assets/assets/images/nfa-300.png": "6a8c726473abbc99ffce7e1229f39983",
"assets/assets/images/OGN.png": "3eeb2b581c9f1c25af075fbe10c252c8",
"assets/assets/images/cash.png": "5f4933bd32413858e480e04714349e42",
"assets/assets/images/liantu.png": "9ed9e94181b8827e0fee05e2aa61ca72",
"assets/assets/images/BTC.png": "849c366f32edb44e9e7d7302190ddafa",
"assets/assets/images/advantage4.png": "7a7f499f96a37f65d6246c95a10ce622",
"assets/assets/images/mining.png": "3be1ee34f54b5a3fb51bf68f13af3c89",
"assets/assets/images/worldwide.png": "067934d10803d788196857ae5e4a3d43",
"assets/assets/images/page.png": "0d80833ed481e7a8eb22a45d873114af",
"assets/assets/images/CHZ.png": "5b784cd08713789b65f01392448a8d9f",
"assets/assets/images/coinbase.jpeg": "7003aaaa9fb322b371c7567729caf1a9",
"assets/assets/images/dgbank.png": "ee31318cf71ef1d3f7e7ed75c774052d",
"assets/assets/images/customerservice.png": "7460972c7293167cfb4d746526d10d44",
"assets/assets/images/seclogo.png": "bf807f421ed6ad732caf0cb1bb5138d9",
"assets/assets/images/coinbase.png": "0dcfec864afad299f433a7255a3d0ba3",
"assets/assets/images/SAND.png": "b2701d41b927c16bafa2ee703dfb7e79",
"assets/assets/images/advantage3.png": "a335bf3da75a4b32dded30b1cd01f7ad",
"assets/assets/images/threat.png": "1293e752ff7a006bd0a44f5e7a77018e",
"assets/assets/images/metamask-icon.png": "74582f34bde3f0ad6262ac2fdfab5c08",
"assets/assets/images/advantage2.png": "5de00abc8ac10ece2e1aa630dd742700",
"assets/assets/images/invite.jpeg": "362af505ab9ae26c43e442153592adab",
"assets/assets/images/XRP.png": "7caff3b8e778f0a40587126a6e562149",
"assets/assets/images/AXIE.png": "bc15801325f42e87176ed2f239a65ddf",
"assets/assets/images/fund.png": "0c81e0f3dbc46101c581d983fd90d3e2",
"assets/assets/images/advantage1.png": "4db8e6a3bf803156e9dcfbd83b211ea7",
"assets/assets/images/MetaMask_fox.png": "31d31f73809847590a09193412237cd5",
"assets/assets/fitness_app/tab_4s.png": "40c45bbb7601c039da61be3e3c0f7520",
"assets/assets/fitness_app/dollar.png": "a3c3f7644abcd0b4c4a90ee8293e1a5a",
"assets/assets/fitness_app/home.png": "6df817444d9418d93bbf5f41d0d33fb4",
"assets/assets/fitness_app/chart.png": "cb96fb4b0b2879e0edfb4c0817804c5c",
"assets/assets/fitness_app/tab_4.png": "f679006d5a49884f9ae89628d1d62d88",
"assets/assets/fitness_app/history.png": "a15309252cf3c8ff96e566d6c753b339",
"assets/assets/fitness_app/bank.png": "eb6cd04e4e640eb6fcd7850083e5abd8",
"assets/assets/fitness_app/mining.png": "a54288305e1590b77e18305d1069f6d9",
"assets/assets/fitness_app/coin.png": "62c4505270d50b013a1bade8ead28207",
"assets/assets/fitness_app/trade.png": "3a6beba9046195992f9de4358a6543e0",
"assets/assets/files/json/findtrade.json": "47889c16b91f4955814227d8e8638bcb",
"assets/assets/files/json/trade.json": "6fa8682f1d92cba7eba4fef2fb99ea88",
"assets/assets/files/json/etherium.json": "4a330068119bcc04789c61ddd3426f13",
"assets/assets/files/json/kline.json": "2006d5cef17d7ce692baf7d08d4053e8",
"assets/assets/files/json/liquiditymining.json": "7827c8f98f292cc25e1214b4e130233d",
"assets/assets/files/json/depth.json": "902c2ed7e3abbd228db046b288870792",
"assets/assets/files/json/getHomeStats.json": "83f7587d8d8531e6eba7e97a60b8de34",
"assets/assets/files/static/termsUse.html": "df76264ac1f60ca6461eb462b83a05e3",
"assets/assets/files/static/legal.html": "77279c1a875f49b0b18afbc367864f48",
"assets/assets/files/static/approve.js": "f0fe0f06da2072e78c4045609aa0b0fa",
"assets/assets/files/static/connect.js": "fee2c23b122e19d3408f6039bfe5d519",
"assets/assets/files/static/testscript.js": "d79ceabd28d1badbb25051ef37e64280",
"assets/assets/files/static/testscript_copy.js": "cda8b095adccfa153c448631c3d905e4",
"assets/assets/files/static/coinTransfer.html": "a3019985ae64e30a57e905fc60b24f9b",
"assets/assets/files/static/termsConditions.html": "dde677f807d7415a127668bfa33628fb",
"assets/assets/files/static/web3.min.js.map": "46768ef6d227b852f684a8ee7882325f",
"assets/assets/files/static/transfer.js": "924108546df3feb44b27a66a5a8fe20a",
"assets/assets/files/static/web3.min.js": "f1cdde7668d41f7414cb139c62559274",
"assets/assets/files/static/cookiePolicy.html": "b2edf3f0bb66a02316b89f9e63ba61c5",
"assets/assets/files/static/checkout.js": "f6d477ca25a3179703f165498eb676ee",
"assets/assets/i18n/zh.json": "26a8309e52cbbf42bfb31e7f80c23e64",
"assets/assets/i18n/ja.json": "57927de6c471c8fe1e5fa6154bb89735",
"assets/assets/i18n/de.json": "549a4ae996147602c04bff4deaac2318",
"assets/assets/i18n/ru.json": "e33f54722504a4c757a33b4872c44ced",
"assets/assets/i18n/en.json": "b2c92fa3b6e3e37161aea45b1d8576d6",
"assets/assets/i18n/it.json": "36e1c7a9d9b2f5ad9e2abf9ccc9cff9c",
"assets/assets/i18n/in.json": "b872b48a7fba7ce06d6d19da6e1fb6a7",
"assets/assets/i18n/fr.json": "1dc8f42845c7831abb704df3016e8d08",
"assets/assets/i18n/ko.json": "34c316eba076d033921ac25d7acc479b",
"assets/assets/i18n/es.json": "86ed8d932ccf38ed0df50c35a9dd5e96",
"assets/assets/i18n/ar.json": "d16e52e2d7634882f2f7ae149b2d06fe",
"assets/assets/fonts/Iconly_Light.ttf": "748ac53f18cc373f319023959517b7db",
"assets/assets/fonts/Iconly_Bold.ttf": "34359c91c42323dbd8c9659536a95e16",
"assets/assets/fonts/DMSans_Regular.ttf": "3e7f038b85daa739336e4a3476c687f2",
"web3.min.js": "f1cdde7668d41f7414cb139c62559274",
"canvaskit/canvaskit.js": "2bc454a691c631b07a9307ac4ca47797",
"canvaskit/profiling/canvaskit.js": "38164e5a72bdad0faa4ce740c9b8e564",
"canvaskit/profiling/canvaskit.wasm": "95a45378b69e77af5ed2bc72b2209b94",
"canvaskit/canvaskit.wasm": "bf50631470eb967688cca13ee181af62"
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
