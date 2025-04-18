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
    apiKey: 'AIzaSyD75bxZXrU1aPJrLTj2DP2OAmS-ZtumZi4',
    appId: '1:786574941246:web:96f6791e4e0e5d57e1c56f',
    messagingSenderId: '786574941246',
    projectId: 'store-app-1fd6c',
    authDomain: 'store-app-1fd6c.firebaseapp.com',
    storageBucket: 'store-app-1fd6c.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCTxfDcJbEqC_RJjS4OVo65E5SbL1-zcD8',
    appId: '1:786574941246:android:17742bddb36b89e7e1c56f',
    messagingSenderId: '786574941246',
    projectId: 'store-app-1fd6c',
    storageBucket: 'store-app-1fd6c.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC4sPT5irrDxqpUJ3QGhzcZuv5Zgv2vCfA',
    appId: '1:786574941246:ios:adeb91ec51ca343be1c56f',
    messagingSenderId: '786574941246',
    projectId: 'store-app-1fd6c',
    storageBucket: 'store-app-1fd6c.firebasestorage.app',
    androidClientId: '786574941246-ko4ss7tegops7qt8ts507og8jutoi0tu.apps.googleusercontent.com',
    iosClientId: '786574941246-114d756gmpd7ej3g5oufmv9c3safo6sf.apps.googleusercontent.com',
    iosBundleId: 'com.example.ytEcommerceAdminPanel',
  );
}
