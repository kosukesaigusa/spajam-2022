import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/voting_event.dart';
import '../../utils/firestore_refs.dart';

final votingEventRepositoryProvider =
    Provider<VotingEventRepository>((_) => VotingEventRepository());

class VotingEventRepository {
  /// List型ではあるが、１つのVotingEvent を返す
  Stream<List<VotingEvent>> subscribeVotingEvent({required String roomId}) {
    final collectionStream = votingEventsRef(roomId: roomId)
        .orderBy('createdAt')
        .limit(1)
        .snapshots();
    return collectionStream.map(
      (qs) => qs.docs.map((qds) => qds.data()).toList(),
    );
  }
}
