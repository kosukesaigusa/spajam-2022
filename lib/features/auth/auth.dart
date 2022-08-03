import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spajam2022/repositories/app_user_repository.dart';
import 'package:spajam2022/utils/exceptions/base.dart';
import 'package:spajam2022/utils/loading.dart';

import '../../utils/logger.dart';

final _authProvider = Provider<FirebaseAuth>((_) => FirebaseAuth.instance);

final authUserProvider = StreamProvider<User?>(
  (ref) => ref.watch(_authProvider).userChanges(),
);

final userIdProvider = Provider<AsyncValue<String?>>(
  (ref) => ref.watch(authUserProvider).whenData((user) => user?.uid),
);

/// FirebaseAuth の匿名ログインを行って、そのユーザー ID でユーザードキュメントを作成する。
final signInAnonymouslyProvider = Provider.autoDispose<Future<void> Function()>(
  (ref) => () async {
    try {
      ref.read(overlayLoadingProvider.notifier).update((state) => true);
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      final user = userCredential.user;
      if (user == null) {
        throw const AppException(message: '匿名サインインに失敗しました。');
      }
      await ref.read(appUserRepositoryProvider).setUser(userId: user.uid);
    } on FirebaseException catch (e) {
      logger.warning(e.toString());
    } on AppException catch (e) {
      logger.warning(e.toString());
    } finally {
      ref.read(overlayLoadingProvider.notifier).update((state) => false);
    }
  },
);

/// FirebaseAuth からログアウトする。
final signOutProvider = Provider.autoDispose<Future<void> Function()>(
  (ref) => () async {
    try {
      ref.read(overlayLoadingProvider.notifier).update((state) => true);
      await FirebaseAuth.instance.signOut();
    } finally {
      ref.read(overlayLoadingProvider.notifier).update((state) => false);
    }
  },
);
