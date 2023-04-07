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
        return macos;
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
    apiKey: 'AIzaSyArqSc_EOJ7FNvhaYE0lD4x0r0Jxsi4MXc',
    appId: '1:35959887505:web:c98fa6470a6c93f8611130',
    messagingSenderId: '35959887505',
    projectId: 'potential-375415',
    authDomain: 'potential-375415.firebaseapp.com',
    storageBucket: 'potential-375415.appspot.com',
    measurementId: 'G-8RTNC1JZKR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7ROTY_m9HCrMSjiyPuznMB6mQouHRNU8',
    appId: '1:35959887505:android:b3bf01511031a31e611130',
    messagingSenderId: '35959887505',
    projectId: 'potential-375415',
    storageBucket: 'potential-375415.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDk_1xPTHkDQINxxuzSIozHFFjc12taTcI',
    appId: '1:35959887505:ios:1b2f6711b041a745611130',
    messagingSenderId: '35959887505',
    projectId: 'potential-375415',
    storageBucket: 'potential-375415.appspot.com',
    androidClientId: '35959887505-dovbo01dm5f8h7o76tt70e0gmninnob7.apps.googleusercontent.com',
    iosClientId: '35959887505-a8gqgfoks8atqi7jara0f9q0if6p7trg.apps.googleusercontent.com',
    iosBundleId: 'com.techmatha.potential',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDk_1xPTHkDQINxxuzSIozHFFjc12taTcI',
    appId: '1:35959887505:ios:1b2f6711b041a745611130',
    messagingSenderId: '35959887505',
    projectId: 'potential-375415',
    storageBucket: 'potential-375415.appspot.com',
    androidClientId: '35959887505-dovbo01dm5f8h7o76tt70e0gmninnob7.apps.googleusercontent.com',
    iosClientId: '35959887505-a8gqgfoks8atqi7jara0f9q0if6p7trg.apps.googleusercontent.com',
    iosBundleId: 'com.techmatha.potential',
  );
}
