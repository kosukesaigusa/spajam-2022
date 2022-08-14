import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'logger.dart';

/// FirebaseMessaging のインスタンスを提供するプロバイダ。ProviderScope.override で上書きする。
final firebaseMessagingProvider = Provider<FirebaseMessaging>((_) => throw UnimplementedError());

/// iOS のフォアグラウンドでの通知受信の設定を済ませて FirebaseMessaging のインスタンスを返す。
/// ProviderScope.overrides で上書きする際に使用する。
Future<FirebaseMessaging> get getFirebaseMessagingInstance async {
  final messaging = FirebaseMessaging.instance;
  if (Platform.isIOS) {
    // Push 通知をフォアグラウンドでも受け取るよう設定する。
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  return messaging;
}

/// FirebaseMessaging 関係の初期化処理を行うメソッドを提供する Provider。
final initializeFirebaseMessagingProvider = Provider.autoDispose<Future<void> Function()>(
  (ref) => () async {
    await ref.read(firebaseMessagingProvider).requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    await ref.read(_getInitialMessageProvider)();
    ref.read(_handleRemoteMessageProvider)();
    // ref.read(firebaseMessagingServiceProvider);
  },
);

/// FCM トークンを取得する Provider。
final getFcmTokenProvider = Provider.autoDispose<Future<String?> Function()>(
  (ref) => () => ref.read(firebaseMessagingProvider).getToken(),
);

/// terminated (!= background) の状態から、通知によってアプリを開いた場合に非 null となる
/// RemoteMessage による挙動を提供する Provider。
final _getInitialMessageProvider = Provider.autoDispose<Future<void> Function()>(
  (ref) => () async {
    /// terminated (!= background) の状態から
    /// 通知によってアプリを開いた場合に remoteMessage が非 null となる。
    final remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage != null) {
      logger.info('🔥 Open app from FCM when terminated.');
      final path = remoteMessage.data['path'] as String;
      final data = remoteMessage.data;
      logger.info('***\npath: $path, data: $data\n***');
      if (remoteMessage.data.containsKey('path')) {
        // await ref.read(navigationServiceProvider).pushOnCurrentTab(path: path, arguments: data);
      }
    }
  },
);

/// foreground or background (!= terminated) の状態で通知が届いたときの
/// RemoteMessage を提供する StreamProvider。
final _remoteMessageStreamProvider = StreamProvider<RemoteMessage>(
  (_) => FirebaseMessaging.onMessageOpenedApp,
);

/// foreground or background (!= terminated) の状態から通知によってアプリを開いた場合の
/// RemoteMessage による挙動を提供する Provider。
final _handleRemoteMessageProvider = Provider(
  (ref) => () => ref.listen<AsyncValue<RemoteMessage>>(
        _remoteMessageStreamProvider,
        (previous, next) {
          logger.info('🔥 FCM notification tapped.');
          final remoteMessage = next.value;
          if (remoteMessage == null) {
            return;
          }
          if (remoteMessage.data.containsKey('path')) {
            final path = remoteMessage.data['path'] as String;
            final data = remoteMessage.data;
            logger.info('***\npath: $path, data: $data\n***');
            // await ref.read(navigationServiceProvider).pushOnCurrentTab(path: path, arguments: data);
          }
        },
      ),
);

/// バックグラウンドから起動した際に Firebase を有効化する。
/// グローバルに記述する必要がある。
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  logger.info('Received remote message on background.');
  await Firebase.initializeApp();
}
