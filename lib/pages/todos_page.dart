import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_bdaya/flutter_datetime_picker_bdaya.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';
import '../features/todo/todo.dart';
import '../models/todo.dart';
import '../repositories/todo_repository.dart';
import '../utils/extensions/date_time.dart';
import '../utils/loading.dart';
import '../utils/scaffold_messenger_service.dart';
import '../widgets/dialog.dart';

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
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
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
          await ref
              .read(scaffoldMessengerServiceProvider)
              .showDialogByBuilder<void>(
                builder: (context) => AlertDialog(
                  title: const Text('Todo の作成'),
                  content: CommonAlertDialogContent(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        TodoTitleTextField(),
                        Gap(16),
                        TodoDescriptionTextField(),
                        Gap(16),
                        TodoDateTimePicker(),
                        Gap(32),
                        SubmitButton(),
                      ],
                    ),
                  ),
                ),
              );
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
          onPressed: () =>
              ref.read(todoRepositoryProvider).toggleTodoStatus(todo),
          icon: Icon(todo.iconData),
        ),
      ],
    );
  }
}

/// Todo のタイトルを入力する TextField。
class TodoTitleTextField extends HookConsumerWidget {
  const TodoTitleTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller:
          ref.watch(todoFormStateNotifierProvider.notifier).titleController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      cursorWidth: 1,
      decoration: const InputDecoration(
        hintText: 'タイトルを入力',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12),
        isDense: true,
        filled: false,
      ),
    );
  }
}

/// Todo の説明を入力する TextField。
class TodoDescriptionTextField extends HookConsumerWidget {
  const TodoDescriptionTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      controller: ref
          .watch(todoFormStateNotifierProvider.notifier)
          .descriptionController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      cursorWidth: 1,
      decoration: const InputDecoration(
        hintText: '説明を入力',
        border: OutlineInputBorder(),
        contentPadding: EdgeInsets.all(12),
        isDense: true,
        filled: false,
      ),
    );
  }
}

/// 期限を選択する DateTimePicker。
class TodoDateTimePicker extends HookConsumerWidget {
  const TodoDateTimePicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dueDateString = ref
        .watch(todoFormStateNotifierProvider)
        .dueDateTime
        ?.toJaYYYYMMDDHHMM();
    return Row(
      children: [
        const Text('期限'),
        TextButton(
          onPressed: () async {
            await DatePicker.showDateTimePicker(
              context,
              minTime: DateTime.now(),
              locale: LocaleType.jp,
              onConfirm: (dateTime) => ref
                  .read(todoFormStateNotifierProvider.notifier)
                  .updateDueDate(dateTime),
            );
          },
          child: Text(dueDateString ?? '設定しない'),
        ),
      ],
    );
  }
}

/// Todo を作成するボタン。
class SubmitButton extends HookConsumerWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      onPressed: () async {
        Navigator.pop(context);
        try {
          await ref.read(todoFormStateNotifierProvider.notifier).submit();
          ref.read(scaffoldMessengerServiceProvider).showSnackBar('作成しました。');
        } on Exception catch (e) {
          ref.read(scaffoldMessengerServiceProvider).showSnackBarByException(e);
        }
      },
      child: const Text('作成する'),
    );
  }
}
