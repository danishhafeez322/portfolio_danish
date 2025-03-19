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
    apiKey: 'AIzaSyCujhn62_7QnE17qjGUWbKDA9UWpNURGA4',
    appId: '1:880915329215:web:a36ceb79b703719600160a',
    messagingSenderId: '880915329215',
    projectId: 'all-in-one-d772a',
    authDomain: 'all-in-one-d772a.firebaseapp.com',
    databaseURL: 'https://all-in-one-d772a-default-rtdb.firebaseio.com',
    storageBucket: 'all-in-one-d772a.firebasestorage.app',
    measurementId: 'G-BG78KEMY3K',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAwq3TG4gUdww5skiFXr7Ha1O4Hp7rLIvE',
    appId: '1:880915329215:android:2c2c8c3cc1cf230e00160a',
    messagingSenderId: '880915329215',
    projectId: 'all-in-one-d772a',
    databaseURL: 'https://all-in-one-d772a-default-rtdb.firebaseio.com',
    storageBucket: 'all-in-one-d772a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDa0W0JVACmryCO9355WXH9aOFQ1bzXlQw',
    appId: '1:880915329215:ios:25972e3ac09ced3b00160a',
    messagingSenderId: '880915329215',
    projectId: 'all-in-one-d772a',
    databaseURL: 'https://all-in-one-d772a-default-rtdb.firebaseio.com',
    storageBucket: 'all-in-one-d772a.firebasestorage.app',
    iosBundleId: 'com.example.portfolioDanish',
  );
}
