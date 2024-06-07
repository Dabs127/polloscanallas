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
    apiKey: 'AIzaSyCNteFMQT-dy7pS3GEhMzQ86WrusadJee8',
    appId: '1:252249481261:web:2b499460a0b8d912cc98a4',
    messagingSenderId: '252249481261',
    projectId: 'pollos-canallas',
    authDomain: 'pollos-canallas.firebaseapp.com',
    storageBucket: 'pollos-canallas.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAI-l8TvxkTTXLC5EgmApIhcxQDvwtpNdk',
    appId: '1:252249481261:android:e60b35091f2ec8cacc98a4',
    messagingSenderId: '252249481261',
    projectId: 'pollos-canallas',
    storageBucket: 'pollos-canallas.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2wmMTPIjStGnQ68grkPaJVvIVLzEGfiU',
    appId: '1:252249481261:ios:5a194448185c58eacc98a4',
    messagingSenderId: '252249481261',
    projectId: 'pollos-canallas',
    storageBucket: 'pollos-canallas.appspot.com',
    iosBundleId: 'com.example.polloscanallas',
  );
}
