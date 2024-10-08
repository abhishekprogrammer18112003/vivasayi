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
    apiKey: 'AIzaSyCM5ggSlVzlzK1ZE-OARd4EZ1ap3Y9BYEI',
    appId: '1:714992012565:web:990b4d40ff740bb8c82d1c',
    messagingSenderId: '714992012565',
    projectId: 'vivasayi-7db1f',
    authDomain: 'vivasayi-7db1f.firebaseapp.com',
    storageBucket: 'vivasayi-7db1f.appspot.com',
    measurementId: 'G-5BR0E5C6L1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAbnU0IRUklkOTFVyRkO4TsMEO1OqXrmjc',
    appId: '1:714992012565:android:a8ae1679204c65adc82d1c',
    messagingSenderId: '714992012565',
    projectId: 'vivasayi-7db1f',
    storageBucket: 'vivasayi-7db1f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDXy31cqGNGx9cTVU7CE7RdcgYfqxbftIo',
    appId: '1:714992012565:ios:7676782c45bfbe43c82d1c',
    messagingSenderId: '714992012565',
    projectId: 'vivasayi-7db1f',
    storageBucket: 'vivasayi-7db1f.appspot.com',
    androidClientId: '714992012565-ll18ll1a6ceruhbr67npkk5vdkgd2uk5.apps.googleusercontent.com',
    iosBundleId: 'com.abhion.vivasayi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDXy31cqGNGx9cTVU7CE7RdcgYfqxbftIo',
    appId: '1:714992012565:ios:7676782c45bfbe43c82d1c',
    messagingSenderId: '714992012565',
    projectId: 'vivasayi-7db1f',
    storageBucket: 'vivasayi-7db1f.appspot.com',
    androidClientId: '714992012565-ll18ll1a6ceruhbr67npkk5vdkgd2uk5.apps.googleusercontent.com',
    iosBundleId: 'com.abhion.vivasayi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCM5ggSlVzlzK1ZE-OARd4EZ1ap3Y9BYEI',
    appId: '1:714992012565:web:7d1053b71cb0edf8c82d1c',
    messagingSenderId: '714992012565',
    projectId: 'vivasayi-7db1f',
    authDomain: 'vivasayi-7db1f.firebaseapp.com',
    storageBucket: 'vivasayi-7db1f.appspot.com',
    measurementId: 'G-EJSZXHBNZL',
  );
}
