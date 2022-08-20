import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../../models/feeling.dart';
import '../../repositories/firestore/feeling_repository.dart';

final myFeelingsProvider = FutureProvider.autoDispose
    .family<List<Feeling>, Tuple3<String, String, String>>((ref, param) async {
  final feelings =
      await ref.watch(feelingRepositoryProvider).getFeelingsByUserId(
            roomId: param.item1,
            votingEventId: param.item2,
            userId: param.item3,
          );
  return feelings;
});
