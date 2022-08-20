import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/voting_event.dart';
import '../../repositories/firestore/voting_event_repository.dart';
import '../../utils/exceptions/base.dart';
import '../auth/auth.dart';

/// VotingEvent 一覧を購読する StreamProvider。
final latestVotingEventStreamProvider =
    StreamProvider.family.autoDispose<VotingEvent, String>((ref, roomId) {
  final userId = ref.watch(userIdProvider).value;
  if (userId == null) {
    throw const AppException(message: 'サインインが必要です。');
  }
  return ref.read(votingEventRepositoryProvider).subscribeLatestVotingEvent(roomId: roomId);
});
