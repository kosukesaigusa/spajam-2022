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
    required Feeling feeling,
  }) async {
    await feelingRef(
      roomId: roomId,
      votingEventId: votingEventId,
      feelingId: feeling.feelingId,
    ).set(feeling);
  }
}
