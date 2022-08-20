import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ルームページ。
class RoomPage extends HookConsumerWidget {
  const RoomPage({super.key});

  static const path = '/room';
  static const name = 'RoomPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ルーム')),
      body: const SizedBox(),
    );
  }
}
