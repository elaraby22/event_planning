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
    apiKey: 'AIzaSyAj_kSZF2Hxjgv1-dzflksegRLcLL1k6dU',
    appId: '1:414811708560:web:ad55f51a32c7e73c4b0c15',
    messagingSenderId: '414811708560',
    projectId: 'event-planning-be56b',
    authDomain: 'event-planning-be56b.firebaseapp.com',
    storageBucket: 'event-planning-be56b.firebasestorage.app',
    measurementId: 'G-Y66ENK5GY9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCODkMAlWjw8etKZi3rP6JlPu8KIhFJndw',
    appId: '1:414811708560:android:8428c79e0a27e4ef4b0c15',
    messagingSenderId: '414811708560',
    projectId: 'event-planning-be56b',
    storageBucket: 'event-planning-be56b.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWuOpgQLkwytJpNxXGaGeoab0ZmwYw5Lo',
    appId: '1:414811708560:ios:3d42deabdf09315d4b0c15',
    messagingSenderId: '414811708560',
    projectId: 'event-planning-be56b',
    storageBucket: 'event-planning-be56b.firebasestorage.app',
    iosBundleId: 'com.example.eventPlanning',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWuOpgQLkwytJpNxXGaGeoab0ZmwYw5Lo',
    appId: '1:414811708560:ios:3d42deabdf09315d4b0c15',
    messagingSenderId: '414811708560',
    projectId: 'event-planning-be56b',
    storageBucket: 'event-planning-be56b.firebasestorage.app',
    iosBundleId: 'com.example.eventPlanning',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAj_kSZF2Hxjgv1-dzflksegRLcLL1k6dU',
    appId: '1:414811708560:web:f11ba6e08fd4910f4b0c15',
    messagingSenderId: '414811708560',
    projectId: 'event-planning-be56b',
    authDomain: 'event-planning-be56b.firebaseapp.com',
    storageBucket: 'event-planning-be56b.firebasestorage.app',
    measurementId: 'G-R71FXQYKWY',
  );
}
