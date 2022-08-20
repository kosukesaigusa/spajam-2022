import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// 投票ページ。
class VotingPage extends HookConsumerWidget {
  const VotingPage({super.key});

  static const path = '/voting';
  static const name = 'VotingPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('投票')),
      body: const SizedBox(),
    );
  }
}
