import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/feeling.dart';
import '../../utils/firestore_refs.dart';

final feelingRepositoryProvider =
    Provider.autoDispose((_) => FeelingRepository());

class FeelingRepository {
  /// 指定した Feeling を作成する。
  Future<void> setFeeling({
    required String roomId,
    required String votingEventId,
    required String userId,
    required Feeling feeling,
  }) async {
    await feelingRef(
      roomId: roomId,
      votingEventId: votingEventId,
      userId: userId,
    ).set(feeling);
  }

  /// 指定したvotingEventのFeelings一覧を取得する
  Future<List<Feeling>> getFeelings({
    required String roomId,
    required String votingEventId,
  }) async {
    final collection =
        await feelingsRef(roomId: roomId, votingEventId: votingEventId)
            .snapshots()
            .first;
    return collection.docs.map((doc) => doc.data()).toList();
  }

  Future<List<Feeling>> getFeelingsByUserId({
    required String roomId,
    required String votingEventId,
    required String userId,
  }) async {
    final collection = await feelingsRef(
      roomId: roomId,
      votingEventId: votingEventId,
    ).where('userId', isEqualTo: userId).snapshots().first;
    return collection.docs.map((doc) => doc.data()).toList();
  }
}
