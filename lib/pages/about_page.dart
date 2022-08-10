import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../features/auth/auth.dart';
import '../utils/hooks/package_info_state.dart';

class AboutPage extends HookConsumerWidget {
  const AboutPage({super.key});

  static const path = '/about';
  static const name = 'AboutPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final packageInfoState = usePackageInfoState();
    final packageInfo = packageInfoState.packageInfo;
    return Scaffold(
      appBar: AppBar(title: const Text('このアプリについて')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('App Name: ${_getAppNameText(packageInfo)}'),
            Text('Version: ${_getVersionInfoText(packageInfo)}'),
            if (ref.watch(isSignedInProvider).value ?? false) ...[
              Text(ref.watch(userIdProvider).value ?? ''),
              ElevatedButton(
                onPressed: () => ref.read(signOutProvider)(),
                child: const Text('サインアウト'),
              )
            ] else
              ElevatedButton(
                onPressed: () => ref.read(signInAnonymouslyProvider)(),
                child: const Text('匿名サインイン'),
              ),
          ],
        ),
      ),
    );
  }

  /// バージョン番号のテキストを取得する
  String _getAppNameText(PackageInfo? packageInfo) => packageInfo?.appName ?? '';

  /// バージョン番号のテキストを取得する
  String _getVersionInfoText(PackageInfo? packageInfo) {
    if (packageInfo == null) {
      return '';
    }
    return '${packageInfo.version}+${packageInfo.buildNumber}';
  }
}
