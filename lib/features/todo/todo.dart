import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/todo.dart';
import '../../repositories/firestore/todo_repository.dart';
import '../../utils/exceptions/base.dart';
import '../../utils/firestore_refs.dart';
import '../../utils/loading.dart';
import '../../utils/uuid.dart';
import '../auth/auth.dart';

/// Todo 一覧の絞り込み条件。
enum TodoFilter {
  all('すべて'),
  due('期限あり'),
  todo('未完了'),
  done('完了');

  const TodoFilter(this.label);

  /// 表示ラベル。
  final String label;

  /// 絞り込み条件のクエリビルダー。
  Query<Todo> Function(Query<Todo> query) get queryBuilder {
    switch (this) {
      case all:
        return (query) => query;
      case due:
        return (query) => query.where('dueDateTime', isNull: false);
      case todo:
        return (query) => query.where('isDone', isEqualTo: false);
      case done:
        return (query) => query.where('isDone', isEqualTo: true);
    }
  }

  /// 絞りこみ結果が空の場合のメッセージ
  String get emptyMessage {
    switch (this) {
      case all:
        return '登録されている Todo がありません。';
      case due:
      case todo:
      case done:
        return '該当する Todo がありません。';
    }
  }
}

/// Todo 一覧の絞り込み条件を管理する StateProvider。
final todoFilterProvider = StateProvider<TodoFilter>((ref) => TodoFilter.all);

/// 指定したユーザーの Todo 一覧を購読する StreamProvider。
final todosStreamProvider = StreamProvider.autoDispose((ref) {
  final userId = ref.watch(userIdProvider).value;
  if (userId == null) {
    return Stream.value(<Todo>[]);
  }
  final todosStream = ref.read(todoRepositoryProvider).subscribeTodos(
        userId: userId,
        todoFilter: ref.watch(todoFilterProvider),
      );
  return todosStream;
});

/// Todo を入力・作成する機能をグループ化して提供する StateNotifierProvider。
final todoFormStateNotifierProvider =
    StateNotifierProvider.autoDispose<TodoFormStateNotifier, Todo>(
  TodoFormStateNotifier.new,
);

class TodoFormStateNotifier extends StateNotifier<Todo> {
  TodoFormStateNotifier(this._ref) : super(const Todo());

  final AutoDisposeStateNotifierProviderRef<TodoFormStateNotifier, Todo> _ref;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  String get title => titleController.value.text;
  String get description => descriptionController.value.text;

  /// Todo の期限を更新する。
  void updateDueDate(DateTime dueDateTime) {
    state = state.copyWith(dueDateTime: dueDateTime);
  }

  /// 入力した Todo を作成する。
  Future<void> submit() async {
    try {
      _validate();
      final userId = _ref.read(userIdProvider).value;
      if (userId == null) {
        throw const AppException(message: 'この操作を行うにはサインインが必要です。');
      }
      _ref.read(overlayLoadingProvider.notifier).update((state) => true);
      final todo = Todo(
        todoId: uuid,
        userId: userId,
        title: title,
        description: description,
        dueDateTime: state.dueDateTime,
      );
      await todoRef(userId: userId, todoId: todo.todoId).set(todo);
    } on Exception {
      rethrow;
    } finally {
      _ref.read(overlayLoadingProvider.notifier).update((state) => false);
    }
  }

  /// フォーム送信前のバリデーションを行う。
  /// 問題があればその理由と一緒に例外をスローする。問題がなければ何もしない。
  void _validate() {
    if (title.isEmpty) {
      throw const AppException(message: 'タイトルを入力してください。');
    }
  }
}
