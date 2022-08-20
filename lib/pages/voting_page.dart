import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/voting_event/vote.dart';
import '../models/vote_enum.dart';
import '../utils/exceptions/base.dart';
import '../utils/routing/app_router_state.dart';
import 'result_page.dart';

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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: <Widget>[
            // TODO(yamatatsu): 確認用なので後で消す
            Text('roomId: ${arguments.roomId}'),
            Text('votingEventId: ${arguments.votingEventId}'),
            for (final vote in VoteEnum.values)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    final navigator = Navigator.of(context);
                    await ref.read(voteProvider).call(
                          roomId: arguments.roomId,
                          votingEventId: arguments.votingEventId,
                          vote: vote,
                        );
                    await navigator.pushReplacementNamed(
                      ResultPage.location(
                        roomId: arguments.roomId,
                        votingEventId: arguments.votingEventId,
                      ),
                    );
                  },
                  splashColor: vote.color,
                  child: Card(
                    elevation: 8,
                    color: vote.color.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DecoratedBox(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 64,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(vote.emoji),
                              const SizedBox(width: 16),
                              Text(
                                vote.label,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
