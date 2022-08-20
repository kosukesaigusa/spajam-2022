import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'app.dart';
import 'utils/application_documents_directory.dart';
import 'utils/firebase_messaging.dart';
import 'utils/setUpLocalEmulator.dart';
import 'utils/settings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // 画面の向きを固定する。
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Firebase を初期化する。
  await Firebase.initializeApp(options: flavor.firebaseOptions);
  // 各種の初期化処理をする。
  await initialize();
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

/// 各種サービス関係での初期化処理を行う。
Future<void> initialize() async {
  await Future.wait<void>([
    if (const String.fromEnvironment('FLAVOR') == 'local') setUpLocalEmulator(),
  ]);
}
