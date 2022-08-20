import '../../models/room.dart';
import '../../utils/firestore_refs.dart';

class RoomRepository {
  Stream<List<Room>> subscribeTodos() {
    final collectionStream = roomsRef.snapshots();
    return collectionStream.map(
      (qs) => qs.docs.map((qds) => qds.data()).toList(),
    );
  }
}
