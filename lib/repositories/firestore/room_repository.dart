import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/room.dart';
import '../../utils/firestore_refs.dart';

final roomRepositoryProvider = Provider<RoomRepository>((_) => RoomRepository());

class RoomRepository {
  Stream<List<Room>> subscribeTodos() {
    final collectionStream = roomsRef.snapshots();
    return collectionStream.map(
      (qs) => qs.docs.map((qds) => qds.data()).toList(),
    );
  }
}
