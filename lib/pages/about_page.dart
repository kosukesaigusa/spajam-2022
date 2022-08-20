import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../features/auth/auth.dart';
import '../models/test_notification_request.dart';
import '../repositories/firestore/test_notification_request_repository.dart';
import '../utils/firebase_messaging.dart';
import '../utils/hooks/package_info_state.dart';
import '../utils/loading.dart';
import '../utils/scaffold_messenger_service.dart';

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
              if (ref.watch(userIdProvider).value?.isNotEmpty ?? false) ...[
                Text(ref.watch(userIdProvider).value ?? ''),
                const Gap(16)
              ],
              ElevatedButton(
                onPressed: () => ref.read(signOutProvider)(),
                child: const Text('サインアウト'),
              )
            ] else
              ElevatedButton(
                onPressed: () => ref.read(signInAnonymouslyProvider)(),
                child: const Text('匿名サインイン'),
              ),
            ElevatedButton(
              onPressed: () => ref.read(showFCMTokenProvider)(),
              child: const Text('FCM トークンを表示'),
            ),
            for (final t in TestNotificationRequestType.values)
              ElevatedButton(
                onPressed: () => ref.read(createTestNotificationRequestProvider)(t),
                child: Text('プッシュ通知をリクエスト (${t.label})'),
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

/// FCM トークンを AlertDialog 上に表示する。
final showFCMTokenProvider = Provider.autoDispose<Future<void> Function()>(
  (ref) => () async {
    try {
      ref.read(overlayLoadingProvider.notifier).update((state) => true);
      final token = await ref.read(getFcmTokenProvider)();
      await ref.read(scaffoldMessengerServiceProvider).showDialogByBuilder<void>(
            builder: (context) => AlertDialog(
              title: const Text('FCM トークン'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (token != null) ...[
                    Text(token),
                    const Gap(8),
                    ElevatedButton(
                      onPressed: () async {
                        final navigator = Navigator.of(context);
                        await Clipboard.setData(ClipboardData(text: token));
                        navigator.pop();
                        ref
                            .read(scaffoldMessengerServiceProvider)
                            .showSnackBar('FCM トークンをクリップボードにコピーしました。');
                      },
                      child: const Text('クリップボードにコピーする'),
                    ),
                  ],
                ],
              ),
            ),
          );
    } finally {
      ref.read(overlayLoadingProvider.notifier).update((state) => false);
    }
  },
);

/// テスト通知を受け取るためのドキュメントを作成する。
final createTestNotificationRequestProvider = Provider.autoDispose<
    Future<void> Function(
  TestNotificationRequestType testNotificationRequestType,
)>(
  (ref) => (testNotificationRequestType) async {
    final token = await ref.read(getFcmTokenProvider)();
    if (token == null) {
      ref.read(scaffoldMessengerServiceProvider).showSnackBar('FCM トークンが取得できませんでした。');
      return;
    }
    try {
      await ref.read(testNotificationRequestRepositoryProvider).create(
            TestNotificationRequest(
              token: token,
              testNotificationRequestType: testNotificationRequestType,
            ),
          );
      ref.read(scaffoldMessengerServiceProvider).showSnackBar(
            'プッシュ通知 (${testNotificationRequestType.label}) をリクエストしました。'
            '通知が届くまで数秒〜数十秒程度お待ちください。',
          );
    } on Exception catch (e) {
      ref.read(scaffoldMessengerServiceProvider).showSnackBarByException(e);
    }
  },
);
