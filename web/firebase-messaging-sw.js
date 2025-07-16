        // Import scripts from Firebase
importScripts('https://www.gstatic.com/firebasejs/10.12.2/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/10.12.2/firebase-messaging-compat.js');

// Initialize Firebase
firebase.initializeApp({
  apiKey: "AIzaSyCfKwvZrjO47da3ggzHKTuy3MzSU9fE5rw",
  authDomain: "shopsphere-b422e.firebaseapp.com",
  projectId: "shopsphere-b422e",
  storageBucket: "shopsphere-b422e.appspot.com",
  messagingSenderId: "909426718408",
  appId: "1:909426718408:web:ddf3b53857e1d1cd8657fd",
  measurementId: "G-S3LFCM69NC"
});

// Retrieve an instance of Firebase Messaging
const messaging = firebase.messaging();
