// File generated manually from Firebase console config (google-services.json
// and GoogleService-Info.plist). Mirrors the shape FlutterFire CLI produces.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Usage:
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
        'this project only registered Android and iOS apps in the console.',
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
          'register a macOS app in the Firebase console if you need this.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'register a web/desktop app in the Firebase console if you need this.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'register a web/desktop app in the Firebase console if you need this.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDiu061RFErcNKOYeDuQ-L14sZtRRTA38I',
    appId: '1:1046661190656:android:1b73ae39e0cdde836234e5',
    messagingSenderId: '1046661190656',
    projectId: 'moviesapp-9d19d',
    storageBucket: 'moviesapp-9d19d.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC8U_G4DABGgUF6w_WaFVLm3rwm2OuEzbI',
    appId: '1:1046661190656:ios:4724c296395e215b6234e5',
    messagingSenderId: '1046661190656',
    projectId: 'moviesapp-9d19d',
    storageBucket: 'moviesapp-9d19d.firebasestorage.app',
    iosBundleId: 'com.example.moviesApp',
  );
}