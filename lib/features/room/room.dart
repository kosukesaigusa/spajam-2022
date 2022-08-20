import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/room.dart';
import '../../repositories/firestore/room_repository.dart';
import '../auth/auth.dart';

/// Room 一覧を購読する StreamProvider。
final roomsStreamProvider = StreamProvider.autoDispose((ref) {
  final userId = ref.watch(userIdProvider).value;
  if (userId == null) {
    return Stream.value(<Room>[]);
  }
  return ref.read(roomsRepositoryProvider).subscribeRooms();
});

final roomStreamProvider =
    StreamProvider.family.autoDispose<Room?, String>((ref, roomId) {
  final result =
      ref.read(roomsRepositoryProvider).subscribeRoom(roomId: roomId);
  return result;
});
