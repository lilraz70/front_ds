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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDocWMDWPv_Xs8zzua3E7rbetzBbve8ajA',
    appId: '1:1056198279796:android:5a3cbd3da19c13d2e78721',
    messagingSenderId: '1056198279796',
    projectId: 'donia-services',
    storageBucket: 'donia-services.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC6OCRNdMzpe9Rfma8zeScxFXB0uZwOTI8',
    appId: '1:1056198279796:ios:a1a89774414ccdc2e78721',
    messagingSenderId: '1056198279796',
    projectId: 'donia-services',
    storageBucket: 'donia-services.appspot.com',
    androidClientId: '1056198279796-1ehv5prn6u40ghpaqh8d6b0qbljdpmi2.apps.googleusercontent.com',
    iosClientId: '1056198279796-ncaiebm9082t82oeo9e0cno0copui7s9.apps.googleusercontent.com',
    iosBundleId: 'com.example.frontDs',
  );
}
