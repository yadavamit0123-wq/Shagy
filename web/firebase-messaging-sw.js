importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.1/firebase-messaging.js");

firebase.initializeApp({
    apiKey: 'AIzaSyADlp8Crl_v_egB_xSa-wANQ9PLn15YRvY',
    appId: '1:108788948261:web:f93ed0c115418402440ecc',
    messagingSenderId: '108788948261',
    projectId: 'shagy-80f44',
    authDomain: 'shagy-80f44.firebaseapp.com',
    databaseURL: 'https://shagy-80f44-default-rtdb.firebaseio.com',
    storageBucket: 'shagy-80f44.firebasestorage.app',
    measurementId: 'G-5MM050KSQ5',
});

const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            const title = payload.notification.title;
            const options = {
                body: payload.notification.score
              };
            return registration.showNotification(title, options);
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});