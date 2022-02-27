// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrhRMpaGmDVztaZxkiTkpird82ZeR5SNA',
    appId: '1:271301214939:android:4bbc42f47c2dfed8a482fe',
    messagingSenderId: '271301214939',
    projectId: 'whosapp-37062',
    storageBucket: 'whosapp-37062.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCRSX64b5-zZDGQzsQXpOmsadjXvc97wtU',
    appId: '1:271301214939:ios:e5035e508a4ec9eea482fe',
    messagingSenderId: '271301214939',
    projectId: 'whosapp-37062',
    storageBucket: 'whosapp-37062.appspot.com',
    iosClientId: '271301214939-n8faurhc3jm0meg14cm23goqj52a5ms7.apps.googleusercontent.com',
    iosBundleId: 'com.example.app',
  );
}
