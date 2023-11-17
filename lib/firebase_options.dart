import 'package:firebase_database/firebase_database.dart';

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'

    show defaultTargetPlatform, kIsWeb, TargetPlatform;

FirebaseDatabase database = FirebaseDatabase.instance;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
final FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyA-B8ancTWKzNcztfuYq9DsHRXw516MqwE",
      authDomain: "lava-jato-68b7a.firebaseapp.com",
      databaseURL: "https://lava-jato-68b7a-default-rtdb.firebaseio.com/",
      projectId: "lava-jato-68b7a",
      storageBucket: "lava-jato-68b7a.appspot.com",
      messagingSenderId: "561263497014",
      appId: "1:561263497014:web:b1a9943385ad52c5d2ed97"
);
