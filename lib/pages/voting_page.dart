import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/vote_enum.dart';

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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          for (final vote in VoteEnum.values)
            ElevatedButton(
              child: Column(
                children: [
                  Text(vote.label),
                ],
              ),
              onPressed: () {
                // TODO: 画面遷移
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
