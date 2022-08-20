import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';
import '../features/todo/todo.dart';
import '../utils/loading.dart';
import '../widgets/empty_placeholder.dart';

/// ルーム一覧ページ
class RoomsPage extends HookConsumerWidget {
  const RoomsPage({super.key});

  static const path = '/rooms';
  static const name = 'RoomsPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider).value;
    return Scaffold(
      appBar: AppBar(title: const Text('ルーム一覧')),
      body: userId == null
          ? const EmptyPlaceholderWidget(
              message: '（仮）ルーム一覧を表示するにはサインインが必要です。'
                  '「About > 匿名サインイン」から匿名でのサインインを行ってください。',
            )
          : ref.watch(todosStreamProvider).when(
                data: (todos) {
                  if (todos.isEmpty) {
                    return EmptyPlaceholderWidget(
                      widget: const FaIcon(
                        FontAwesomeIcons.list,
                        color: Colors.black45,
                        size: 48,
                      ),
                      message: '${ref.watch(todoFilterProvider).emptyMessage}TODO がありません。'
                          '右下のペンボタンから、TODO を登録してください。',
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: todos.length,
                    padding: const EdgeInsets.all(16),
                    // TODO: 仮で SizedBox() にしています。
                    // itemBuilder: (context, index) => RoomItem(todo: todos[index]),
                    itemBuilder: (context, index) => const SizedBox(),
                  );
                },
                error: (_, __) => const SizedBox(),
                loading: () => const PrimarySpinkitCircle(),
              ),
    );
  }
}
