import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/vote_enum.dart';
import '../utils/exceptions/base.dart';
import '../utils/routing/app_router_state.dart';

/// VotingPageArguments インスタンスを取得してから返す Provider。
final votingPageArgumentsProvider = Provider.autoDispose<VotingPageArguments>(
  (ref) {
    try {
      final state = ref.read(appRouterStateProvider);
      final roomId = state.params['roomId']!;
      final votingEventId = state.params['votingEventId']!;
      return VotingPageArguments(
        roomId: roomId,
        votingEventId: votingEventId,
      );
    } on Exception {
      throw const AppException(message: '投票ページが見つかりませんでした。');
    }
  },
  dependencies: <ProviderOrFamily>[
    appRouterStateProvider,
  ],
);

/// 投票ページの引数。
class VotingPageArguments {
  VotingPageArguments({
    required this.roomId,
    required this.votingEventId,
  });
  final String roomId;
  final String votingEventId;
}

/// 投票ページ。
class VotingPage extends HookConsumerWidget {
  const VotingPage({super.key});

  static const path = '/rooms/:roomId/:votingEventId';
  static const name = 'VotingPage';
  static String location({
    required String roomId,
    required String votingEventId,
  }) =>
      '/rooms/$roomId/$votingEventId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final arguments = ref.watch(votingPageArgumentsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('投票')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: <Widget>[
          // TODO(yamatatsu): 確認用なので後で消す
          Text(arguments.roomId),
          Text(arguments.votingEventId),
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
