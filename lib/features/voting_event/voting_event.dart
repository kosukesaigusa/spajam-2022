import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../models/voting_event.dart';
import '../../repositories/firestore/voting_event_repository.dart';
import '../../utils/exceptions/base.dart';
import '../auth/auth.dart';

/// 最新の VotingEvent 一覧を購読する StreamProvider。
final latestVotingEventStreamProvider =
    StreamProvider.family.autoDispose<VotingEvent, String>((ref, roomId) {
  final userId = ref.watch(userIdProvider).value;
  if (userId == null) {
    throw const AppException(message: 'サインインが必要です。');
  }
  return ref.read(votingEventRepositoryProvider).subscribeLatestVotingEvent(roomId: roomId);
});

/// 指定した VotingEvent 一覧を購読する StreamProvider。
/// スコープが狭いので Tuple を使用する
final votingEventStreamProvider =
    StreamProvider.family.autoDispose<VotingEvent?, Tuple2<String, String>>((ref, tuple) {
  final userId = ref.watch(userIdProvider).value;
  if (userId == null) {
    throw const AppException(message: 'サインインが必要です。');
  }
  final result = ref
      .read(votingEventRepositoryProvider)
      .subscribeVotingEvent(roomId: tuple.item1, votingEventId: tuple.item2);
  return result;
});
