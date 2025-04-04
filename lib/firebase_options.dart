// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCfKwvZrjO47da3ggzHKTuy3MzSU9fE5rw',
    appId: '1:909426718408:web:ddf3b53857e1d1cd8657fd',
    messagingSenderId: '909426718408',
    projectId: 'shopsphere-b422e',
    authDomain: 'shopsphere-b422e.firebaseapp.com',
    storageBucket: 'shopsphere-b422e.firebasestorage.app',
    measurementId: 'G-S3LFCM69NC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDAUBFD_FqC6r5qlGdl5JYRiaVTHtPms48',
    appId: '1:909426718408:android:f3d7eedbb8ecc3c08657fd',
    messagingSenderId: '909426718408',
    projectId: 'shopsphere-b422e',
    storageBucket: 'shopsphere-b422e.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDwtz_H0VeaxfBOJN8EbeQNSWsmFDcypGQ',
    appId: '1:909426718408:ios:ccbacf06eec415e68657fd',
    messagingSenderId: '909426718408',
    projectId: 'shopsphere-b422e',
    storageBucket: 'shopsphere-b422e.firebasestorage.app',
    iosBundleId: 'com.example.shopSphere',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDwtz_H0VeaxfBOJN8EbeQNSWsmFDcypGQ',
    appId: '1:909426718408:ios:ccbacf06eec415e68657fd',
    messagingSenderId: '909426718408',
    projectId: 'shopsphere-b422e',
    storageBucket: 'shopsphere-b422e.firebasestorage.app',
    iosBundleId: 'com.example.shopSphere',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCfKwvZrjO47da3ggzHKTuy3MzSU9fE5rw',
    appId: '1:909426718408:web:bc115e1dcb51840d8657fd',
    messagingSenderId: '909426718408',
    projectId: 'shopsphere-b422e',
    authDomain: 'shopsphere-b422e.firebaseapp.com',
    storageBucket: 'shopsphere-b422e.firebasestorage.app',
    measurementId: 'G-XYPXBF4JD1',
  );
}
