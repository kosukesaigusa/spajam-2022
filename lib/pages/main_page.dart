import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  static const path = '/main';
  static const name = 'MainPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('aaa')),
      body: const Center(child: Text('aaa')),
    );
  }
}
