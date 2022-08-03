import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'app.dart';
import 'firebase_options/firebase_options_dev.dart' as dev;
import 'firebase_options/firebase_options_prod.dart' as prod;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: _firebaseOptionsByFlavor);
  runApp(const ProviderScope(child: App()));
}

FirebaseOptions get _firebaseOptionsByFlavor {
  const flavor = String.fromEnvironment('FLAVOR');
  switch (flavor) {
    case 'prod':
      return prod.DefaultFirebaseOptions.currentPlatform;
    case 'dev':
      return dev.DefaultFirebaseOptions.currentPlatform;
  }
  return dev.DefaultFirebaseOptions.currentPlatform;
}
