import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';
import '../features/todo/todo.dart';
import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import '../utils/extensions/date_time.dart';
import '../utils/loading.dart';
import '../utils/uuid.dart';

/// Todo 一覧ページ。
class TodosPage extends HookConsumerWidget {
  const TodosPage({super.key});

  static const path = '/todos';
  static const name = 'TodosPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('Todo 一覧')),
      body: userId == null
          ? const SizedBox()
          : ref.watch(todosStreamProvider).when(
                data: (todos) {
                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TodoItem(todo: todos[index]),
                    ),
                  );
                },
                error: (_, __) => const SizedBox(),
                loading: () => const PrimarySpinkitCircle(),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final userId = ref.read(userIdProvider).value;
          if (userId == null) {
            return;
          }
          final todo = Todo(todoId: uuid, userId: userId);
          await ref.read(todoRepositoryProvider).setTodo(todo: todo);
        },
        child: const FaIcon(FontAwesomeIcons.pen),
      ),
    );
  }
}

/// Todo のひとつひとつのウィジェット。
class TodoItem extends HookConsumerWidget {
  const TodoItem({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.title),
            if (todo.description.isNotEmpty) Text(todo.description),
            if (todo.dueDateTime != null)
              Text('期限：${todo.dueDateTime!.toYYYYMMDDHHMM()}')
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.check_box),
        ),
      ],
    );
  }
}
