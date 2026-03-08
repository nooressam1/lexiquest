

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return const FirebaseOptions(
        apiKey: "AIzaSyDF7c69x1_0Nvy0X6nnkcwlPRJN_p2UYcc",
        authDomain: "lexiquest-371c8.firebaseapp.com",
        projectId: "lexiquest-371c8",
        storageBucket: "lexiquest-371c8.firebasestorage.app",
        messagingSenderId: "481348663732",
        appId: "1:481348663732:web:82bd1606cfc961419a5ae1",
        measurementId: "G-7FMLFW1YB1",
      );
    }

    // For Android and iOS, config comes from google-services.json / GoogleService-Info.plist
    return const FirebaseOptions(
      apiKey: "AIzaSyDF7c69x1_0Nvy0X6nnkcwlPRJN_p2UYcc",
      appId: "1:481348663732:android:auto_generated_placeholder",
      messagingSenderId: "481348663732",
      projectId: "lexiquest-371c8",
      storageBucket: "lexiquest-371c8.firebasestorage.app",
    );
  }
}
