import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/todo.dart';
import '../../repositories/todo_repository.dart';
import '../auth/auth.dart';

/// 指定したユーザーの Todo 一覧を購読する StreamProvider。
final todosStreamProvider = StreamProvider.autoDispose((ref) {
  final userId = ref.watch(userIdProvider).value;
  if (userId == null) {
    return Stream.value(<Todo>[]);
  }
  final todosStream =
      ref.read(todoRepositoryProvider).subscribeTodos(userId: userId);
  return todosStream;
});
