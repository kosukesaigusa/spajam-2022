import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/voting_event/voting_event.dart';
import '../models/voting_event_status.dart';
import '../utils/exceptions/base.dart';
import '../utils/loading.dart';
import '../utils/routing/app_router_state.dart';

/// roomId を取得してから返す Provider。
final _roomIdProvider = Provider.autoDispose<String>(
  (ref) {
    try {
      final state = ref.read(appRouterStateProvider);
      final roomId = state.params['roomId']!;
      return roomId;
    } on Exception {
      throw const AppException(message: 'ルームが見つかりませんでした。');
    }
  },
  dependencies: <ProviderOrFamily>[
    appRouterStateProvider,
  ],
);

/// 投票結果ページ。
/// 対象の VotingEvent.status が voting or finished のときに表示する想定。
class ResultPage extends HookConsumerWidget {
  const ResultPage({super.key});

  static const path = '/rooms/:roomId/:votingEventId/result';
  static const name = 'ResultPage';
  static String location({
    required String roomId,
    required String votingEventId,
  }) =>
      '/rooms/$roomId/$votingEventId/result';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final roomId = ref.watch(_roomIdProvider);
    return ref.watch(votingEventStreamProvider(roomId)).when(
          data: (voteEvent) {
            switch (voteEvent.status) {
              case VotingEventStatus.voting:
                return const VotingWidget();
              case VotingEventStatus.finished:
                return const FinishedWidget();
              // ignore: no_default_cases
              default:
                return Scaffold(
                  appBar: AppBar(title: const Text('エラー')),
                  body: const Center(
                    child: Text('投票結果ページには投票中または終了済みのイベントに対してのみ表示できます。'),
                  ),
                );
            }
          },
          error: (error, stackTrace) => Scaffold(
            appBar: AppBar(title: const Text('投票結果')),
            body: Center(
              child: Text(error.toString()),
            ),
          ),
          loading: () => Scaffold(
            appBar: AppBar(title: const Text('')),
            body: const Center(
              child: PrimarySpinkitCircle(),
            ),
          ),
        );
  }
}

/// 結果ページの、投票中 (voting) 状態のときに表示するウィジェット。
class VotingWidget extends HookConsumerWidget {
  const VotingWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: Text('投票中'));
  }
}

/// 結果ページの、投票終了 (finished) 状態のときに表示するウィジェット。
class FinishedWidget extends HookConsumerWidget {
  const FinishedWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(body: Text('投票終了'));
  }
}
