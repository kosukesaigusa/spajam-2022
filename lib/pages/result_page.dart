import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
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
    return ref
        .watch(votingEventStreamProvider(Tuple2(roomId, votingEventId)))
        .when(
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
class FinishedWidget extends StatefulHookConsumerWidget {
  const FinishedWidget({
    super.key,
    required this.resultText,
  });

  final String resultText;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FinishedWidgetState();
}

class _FinishedWidgetState extends ConsumerState<FinishedWidget> {
  bool changeWidgets = false;
  final confettiController =
      ConfettiController(duration: const Duration(minutes: 10));

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final castleController = useAnimationController(
      // initialValue: 0.8,
      duration: const Duration(milliseconds: 2300),
    );

    final birdController = useAnimationController(
      duration: const Duration(milliseconds: 2300),
    );

    final birdAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(birdController);

    useEffect(
      () {
        castleController.animateTo(1).whenComplete(() async {
          confettiController.play();
          await Future<void>.delayed(const Duration(milliseconds: 500));
          await birdController.animateTo(1).whenComplete(
            () async {
              await Future<void>.delayed(const Duration(milliseconds: 800));
              setState(() {
                changeWidgets = true;
              });
            },
          );
        });
        return null;
      },
      [],
    );

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('エアコン戦争に終止符が打たれました 🙌'),
        //   automaticallyImplyLeading: false,
        // ),
        body: Stack(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: <Color>[
                    Colors.yellow[800]!,
                    Colors.yellow[500]!,
                    Colors.yellow[300]!,
                  ],
                ),
              ),
              child: Center(
                child: LottieBuilder.asset(
                  'assets/lotties/peace.json',
                  repeat: false,
                  controller: castleController,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.7),
            ),
            // 鳥とテキスト用のwidget
            Center(
              child: SlideTransition(
                position: birdAnimation,
                child: FadeTransition(
                  opacity: birdController,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 1800),
                    child: !changeWidgets
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(height: 50),
                              const Text(
                                'エアコン戦争に\n終止符が打たれました 🙌',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24,),
                              ),
                              Image.asset('assets/images/bird.png'),
                            ],
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.resultText,
                                  // textAlign: TextAlign.center,
                                  style:
                                      context.textTheme.headlineLarge!.copyWith(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30),
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                blastDirection: pi / 2,
                emissionFrequency: 0.1,
                numberOfParticles: 5,
                maxBlastForce: 15,
                minBlastForce: 1,
                shouldLoop: true,
                gravity: 0.1,
                maximumSize: const Size(15, 15),
                minimumSize: const Size(10, 10),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: ElevatedButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    shape: const StadiumBorder(),
                  ),
                  child: const Text('終戦'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
