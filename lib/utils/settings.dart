import 'package:firebase_core/firebase_core.dart';

import 'firebase_options/firebase_options_dev.dart' as dev_options;
import 'firebase_options/firebase_options_prod.dart' as prod_options;

/// GitHub API へのリクエストに使用する個人アクセストークン
const gitHubToken = String.fromEnvironment('GITHUB_TOKEN');

const flavorString = String.fromEnvironment('FLAVOR');
final flavor = Flavor.values.firstWhere((f) => f.name == flavorString);

/// Flutter のビルドオプションの flavor
enum Flavor {
  local,
  dev,
  prod;

  const Flavor();

  FirebaseOptions get firebaseOptions {
    switch (this) {
      case prod:
        return prod_options.DefaultFirebaseOptions.currentPlatform;
      case dev:
      case local:
        return dev_options.DefaultFirebaseOptions.currentPlatform;
    }
  }
}
