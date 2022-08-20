import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/vote.dart';
import '../../models/vote_enum.dart';
import '../../repositories/firestore/vote_repository.dart';
import '../../utils/exceptions/base.dart';
import '../../utils/loading.dart';
import '../../utils/scaffold_messenger_service.dart';
import '../auth/auth.dart';

/// 投票を行うメソッド。
final voteProvider = Provider<
    Future<void> Function({
  required String roomId,
  required String votingEventId,
  required VoteEnum vote,
})>((ref) {
  return ({
    required roomId,
    required votingEventId,
    required vote,
  }) async {
    final userId = ref.watch(userIdProvider).value;
    if (userId == null) {
      throw const AppException(message: 'サインインが必要です。');
    }

    try {
      ref.read(overlayLoadingProvider.notifier).update((state) => true);
      await ref.read(voteRepositoryProvider).vote(
            roomId: roomId,
            votingEventId: votingEventId,
            vote: Vote(userId: userId, vote: vote),
          );
      ref.read(scaffoldMessengerServiceProvider).showSnackBar('投票しました。');
    } on Exception catch (e) {
      ref.read(scaffoldMessengerServiceProvider).showSnackBarByException(e);
    } finally {
      ref.read(overlayLoadingProvider.notifier).update((state) => false);
    }
  };
});
