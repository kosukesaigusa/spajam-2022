import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Todo 一覧ページ。
class TodosPage extends HookConsumerWidget {
  const TodosPage({super.key});

  static const path = '/todos';
  static const name = 'TodosPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo 一覧')),
      body: const SizedBox(),
    );
  }
}
