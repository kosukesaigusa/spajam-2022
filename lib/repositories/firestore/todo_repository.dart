import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../features/todo/todo.dart';
import '../../models/todo.dart';
import '../../utils/firestore_refs.dart';
import '../../utils/logger.dart';

final todoRepositoryProvider = Provider.autoDispose((_) => TodoRepository());

class TodoRepository {
  /// 指定した Todo を取得する。
  Future<Todo?> fetchTodo({
    required String userId,
    required String todoId,
  }) async {
    final ds = await todoRef(userId: userId, todoId: todoId).get();
    if (!ds.exists) {
      logger.warning('Document not found: ${ds.reference.path}');
      return null;
    }
    return ds.data()!;
  }

  /// 指定したユーザー かつ TodoFilter の条件で絞り込んだ Todo 一覧を購読する。
  Stream<List<Todo>> subscribeTodos({
    required String userId,
    required TodoFilter todoFilter,
  }) {
    final collectionStream = todoFilter.queryBuilder(todosRef(userId: userId)).snapshots();
    return collectionStream.map(
      (qs) => qs.docs.map((qds) => qds.data()).toList(),
    );
  }

  /// 指定したユーザーの Todo を作成する。
  Future<void> setTodo({
    required Todo todo,
    SetOptions? setOptions,
  }) async {
    await todoRef(userId: todo.userId, todoId: todo.todoId).set(todo, setOptions);
  }

  /// 指定した Todo の isDone を切り替える
  Future<void> toggleTodoStatus(Todo todo) async {
    await todoRef(userId: todo.userId, todoId: todo.todoId)
        .set(todo.copyWith(isDone: !todo.isDone), SetOptions(merge: true));
  }
}
