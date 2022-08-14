import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'utils/application_documents_directory.dart';
import 'utils/firebase_messaging.dart';
import 'utils/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: flavor.firebaseOptions);
  runApp(
    ProviderScope(
      overrides: <Override>[
        applicationDocumentsDirectoryProvider.overrideWithValue(
          await getApplicationDocumentsDirectory(),
        ),
        firebaseMessagingProvider.overrideWithValue(
          await getFirebaseMessagingInstance,
        ),
      ],
      child: const App(),
    ),
  );
}
