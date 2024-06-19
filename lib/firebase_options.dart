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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDifjK8ISrMb4lPVbid56y6-THcGLCLlCM',
    appId: '1:172875964228:android:f044584087618e59674111',
    messagingSenderId: '172875964228',
    projectId: 'we-text-11e74',
    storageBucket: 'we-text-11e74.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCy6JhLwO1lXzgZ-Rtzffqsia49v-MHrZU',
    appId: '1:172875964228:ios:70b9714512758df4674111',
    messagingSenderId: '172875964228',
    projectId: 'we-text-11e74',
    storageBucket: 'we-text-11e74.appspot.com',
    androidClientId: '172875964228-bdf1ttguclbbu4uovpa9vrgvkg8fl025.apps.googleusercontent.com',
    iosClientId: '172875964228-v7vq2go9gd7gm72tdsfiuodcghtpojh3.apps.googleusercontent.com',
    iosBundleId: 'com.example.weText2',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDXXOlJ3okIKo8ALtHZiWXMnhu0Dl81wRA',
    appId: '1:172875964228:web:b30a5d32aeb1f6e3674111',
    messagingSenderId: '172875964228',
    projectId: 'we-text-11e74',
    authDomain: 'we-text-11e74.firebaseapp.com',
    storageBucket: 'we-text-11e74.appspot.com',
    measurementId: 'G-RSJVG94GKR',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCy6JhLwO1lXzgZ-Rtzffqsia49v-MHrZU',
    appId: '1:172875964228:ios:70b9714512758df4674111',
    messagingSenderId: '172875964228',
    projectId: 'we-text-11e74',
    storageBucket: 'we-text-11e74.appspot.com',
    androidClientId: '172875964228-bdf1ttguclbbu4uovpa9vrgvkg8fl025.apps.googleusercontent.com',
    iosClientId: '172875964228-v7vq2go9gd7gm72tdsfiuodcghtpojh3.apps.googleusercontent.com',
    iosBundleId: 'com.example.weText2',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDXXOlJ3okIKo8ALtHZiWXMnhu0Dl81wRA',
    appId: '1:172875964228:web:49761cff9dfc1ada674111',
    messagingSenderId: '172875964228',
    projectId: 'we-text-11e74',
    authDomain: 'we-text-11e74.firebaseapp.com',
    storageBucket: 'we-text-11e74.appspot.com',
    measurementId: 'G-VYDBL3LR59',
  );

}