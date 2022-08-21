import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tuple/tuple.dart';

import '../features/auth/auth.dart';
import '../features/voting_event/voting_event.dart';
import '../models/voting_event_status.dart';
import '../repositories/firestore/voting_event_repository.dart';
import '../utils/constants/number.dart';
import '../utils/exceptions/base.dart';
import '../utils/extensions/build_context.dart';
import '../utils/hooks/interval.dart';
import '../utils/loading.dart';
import '../utils/logger.dart';
import '../utils/routing/app_router_state.dart';
import '../widgets/empty_placeholder.dart';

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

/// votingEventId を取得してから返す Provider。
final _votingEventIdProvider = Provider.autoDispose<String>(
  (ref) {
    try {
      final state = ref.read(appRouterStateProvider);
      final votingEventId = state.params['votingEventId']!;
      return votingEventId;
    } on Exception {
      throw const AppException(message: '投票イベントのIDが見つかりませんでした。');
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
    final votingEventId = ref.watch(_votingEventIdProvider);
    return ref.watch(votingEventStreamProvider(Tuple2(roomId, votingEventId))).when(
          data: (votingEvent) {
            if (votingEvent == null) {
              return Scaffold(
                appBar: AppBar(title: const Text('エラー')),
                body: const EmptyPlaceholderWidget(
                  message: '有効な投票イベントが存在しません',
                ),
              );
            }
            switch (votingEvent.status) {
              case VotingEventStatus.voting:
                return const VotingWidget();
              case VotingEventStatus.finished:
                return FinishedWidget(
                  resultText: votingEvent.result.resultText,
                );
              case VotingEventStatus.peace:
              case VotingEventStatus.waiting:
                return Scaffold(
                  appBar: AppBar(title: const Text('エラー')),
                  body: const EmptyPlaceholderWidget(
                    message: '投票結果ページには投票中または終了済みのイベントに対してのみ表示できます。',
                  ),
                );
            }
          },
          error: (error, stackTrace) => Scaffold(
            appBar: AppBar(
              title: const Text('投票結果'),
              automaticallyImplyLeading: false,
              leading: const SizedBox(),
            ),
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
    final userId = ref.watch(userIdProvider).value;
    if (userId == null) {
      return const EmptyPlaceholderWidget(message: 'サインインが必要です');
    }
    final countDown = useState(votingSeconds);
    final delay = useState(const Duration(milliseconds: 1000));
    final isRunning = useState(true);
    logger.info('残り ${countDown.value} 秒');
    useInterval(
      () {
        countDown.value--;
      },
      isRunning.value ? delay.value : null,
    );
    if (countDown.value <= 0) {
      final roomId = ref.watch(_roomIdProvider);
      final votingEventId = ref.watch(_votingEventIdProvider);
      ref.read(votingEventRepositoryProvider).createCompleteVotingEventRequest(
            roomId: roomId,
            votingEventId: votingEventId,
            userId: userId,
          );
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            children: const [
              Text('投票中'),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        // TODO: ここの表示をいい感じにしてほしい
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 200,
                height: 200,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CircularProgressIndicator(
                      value: countDown.value / votingSeconds,
                      strokeWidth: 12,
                    ),
                    if (countDown.value > 0)
                      Center(
                        child: Align(
                          alignment: const Alignment(0.25, 0),
                          child: Text(
                            '${countDown.value} ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: context.theme.primaryColor,
                              fontSize: 80,
                            ),
                          ),
                        ),
                      )
                  ],
                ),
              ),
              if (countDown.value > 0) ...[
                const Gap(40),
                Text(
                  '投票終了まで...',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.theme.primaryColor,
                    fontSize: 40,
                  ),
                )
              ] else if (countDown.value <= 0)
                Center(
                  child: Text(
                    'もうすぐ結果が確定します...',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.theme.primaryColor,
                      fontSize: 25,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 結果ページの、投票終了 (finished) 状態のときに表示するウィジェット。
class FinishedWidget extends HookConsumerWidget {
  const FinishedWidget({
    super.key,
    required this.resultText,
  });

  final String resultText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('エアコン戦争に終止符が打たれました 🙌'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  resultText,
                  style: context.textTheme.headlineLarge!.copyWith(
                    color: Colors.black87,
                  ),
                ),
                const Gap(32),
                ElevatedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  child: const Text('戻る'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
