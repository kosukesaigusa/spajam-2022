import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// ルームページ。
class RoomPage extends HookConsumerWidget {
  const RoomPage({super.key});

  static const path = '/rooms/:roomId';
  static const name = 'RoomPage';
  static String location({required String roomId}) => '/rooms/$roomId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('ルーム')),
      body: const SizedBox(),
    );
  }
}
