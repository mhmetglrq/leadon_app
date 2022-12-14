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
    apiKey: 'AIzaSyDGmmNr_JD3FLsnnHBwFMtNljJx9Cbtb-o',
    appId: '1:572770707732:web:46fb147397fbe580537a01',
    messagingSenderId: '572770707732',
    projectId: 'leadonapp-d2589',
    authDomain: 'leadonapp-d2589.firebaseapp.com',
    storageBucket: 'leadonapp-d2589.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDUZYdNll78kmQdtg-XS2RHzclhjKdxuII',
    appId: '1:572770707732:android:8c73dc0b6a740dc6537a01',
    messagingSenderId: '572770707732',
    projectId: 'leadonapp-d2589',
    storageBucket: 'leadonapp-d2589.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBWOzaqkCYYdl5x4HKXQreSM1Cz4VnD8SU',
    appId: '1:572770707732:ios:c63593979c76e141537a01',
    messagingSenderId: '572770707732',
    projectId: 'leadonapp-d2589',
    storageBucket: 'leadonapp-d2589.appspot.com',
    iosClientId: '572770707732-2peqf6r7o6u8f90m7dobv74o7ajaapmj.apps.googleusercontent.com',
    iosBundleId: 'com.example.leadonApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBWOzaqkCYYdl5x4HKXQreSM1Cz4VnD8SU',
    appId: '1:572770707732:ios:c63593979c76e141537a01',
    messagingSenderId: '572770707732',
    projectId: 'leadonapp-d2589',
    storageBucket: 'leadonapp-d2589.appspot.com',
    iosClientId: '572770707732-2peqf6r7o6u8f90m7dobv74o7ajaapmj.apps.googleusercontent.com',
    iosBundleId: 'com.example.leadonApp',
  );
}
