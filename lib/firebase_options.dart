// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyBvXwn0XBpA-odHWySsHrF0rBiTlDQo5JQ',
    appId: '1:248635777986:web:2db7761d80076b3b4eec5b',
    messagingSenderId: '248635777986',
    projectId: 'chat-app-50519',
    authDomain: 'chat-app-50519.firebaseapp.com',
    storageBucket: 'chat-app-50519.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDrQm7WMQ-jA_VeldEWlYBZxMphyHPntgc',
    appId: '1:248635777986:android:c03cdf50b0832e414eec5b',
    messagingSenderId: '248635777986',
    projectId: 'chat-app-50519',
    storageBucket: 'chat-app-50519.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6pSX2YO-Cz8kr3C5cBzZKZSKO-SNb49k',
    appId: '1:248635777986:ios:aca34c2e6a24590b4eec5b',
    messagingSenderId: '248635777986',
    projectId: 'chat-app-50519',
    storageBucket: 'chat-app-50519.appspot.com',
    iosClientId:
        '248635777986-as20s13hfjja3elvg3q5usbgvukojnu6.apps.googleusercontent.com',
    iosBundleId: 'com.example.chatApp',
  );
}
