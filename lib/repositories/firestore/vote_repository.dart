import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/vote.dart';
import '../../utils/firestore_refs.dart';

final voteRepositoryProvider =
    Provider<VotingEventRepository>((_) => VotingEventRepository());

class VotingEventRepository {
  /// 最新の１つの VotingEvent を返す
  /// Room が作成されたときに、必ず１つの VotingEvent が作成されている
  Future<void> vote({
    required String roomId,
    required String votingEventId,
    required Vote vote,
  }) async {
    final voteRef =
        votesRef(roomId: roomId, votingEventId: votingEventId).doc(vote.userId);
    await voteRef.set(vote);
  }
}
