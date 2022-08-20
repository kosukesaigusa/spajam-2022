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
