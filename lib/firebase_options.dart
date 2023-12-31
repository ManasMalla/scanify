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
    apiKey: 'AIzaSyDJshiMyaVbzZlCkmUY9tvoB74qZ9bBCf4',
    appId: '1:1006689064972:web:34a4b7a29b77d151edb629',
    messagingSenderId: '1006689064972',
    projectId: 'g-samay',
    authDomain: 'g-samay.firebaseapp.com',
    storageBucket: 'g-samay.appspot.com',
    measurementId: 'G-NVW6QR6CD4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC9hAE3O0a1Xhy96y6tRSflHxBeObY5Xy4',
    appId: '1:1006689064972:android:ae8b565a1ec737b9edb629',
    messagingSenderId: '1006689064972',
    projectId: 'g-samay',
    storageBucket: 'g-samay.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAM-zf289Y6euoT23dsJQ11STgbyDn8zb4',
    appId: '1:1006689064972:ios:26f4eb87d4b70e37edb629',
    messagingSenderId: '1006689064972',
    projectId: 'g-samay',
    storageBucket: 'g-samay.appspot.com',
    iosClientId: '1006689064972-i82jrvk98u6npvdih6ae9dqg6lsfgr6v.apps.googleusercontent.com',
    iosBundleId: 'in.theananta.scanify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAM-zf289Y6euoT23dsJQ11STgbyDn8zb4',
    appId: '1:1006689064972:ios:35e23fd02b9f44ffedb629',
    messagingSenderId: '1006689064972',
    projectId: 'g-samay',
    storageBucket: 'g-samay.appspot.com',
    iosClientId: '1006689064972-p7j3qfd3isjmp24mmdhajmvb5cnbk1mh.apps.googleusercontent.com',
    iosBundleId: 'in.theananta.scanify.RunnerTests',
  );
}
