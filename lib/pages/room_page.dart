import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tuple/tuple.dart';

import '../features/auth/auth.dart';
import '../features/room/room.dart';
import '../features/voting_event/feeling.dart';
import '../features/voting_event/voting_event.dart';
import '../models/feeling.dart';
import '../models/voting_event.dart';
import '../models/voting_event_status.dart';
import '../repositories/firestore/feeling_repository.dart';
import '../utils/exceptions/base.dart';
import '../utils/routing/app_router_state.dart';
import '../utils/scaffold_messenger_service.dart';
import '../widgets/empty_placeholder.dart';
import 'voting_page.dart';

/// roomId を取得してから返す Provider。
final roomIdProvider = Provider.autoDispose<String>(
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

/// ルームページ。
class RoomPage extends HookConsumerWidget {
  const RoomPage({super.key});

  static const path = '/rooms/:roomId';
  static const name = 'RoomPage';
  static String location({required String roomId}) => '/rooms/$roomId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider).value;
    final roomId = ref.watch(roomIdProvider);

    Widget baseScaffold(Widget body, {Widget? floatingActionButton}) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            ref.watch(roomStreamProvider(roomId)).when(
                  data: (room) => room!.roomName,
                  error: (_, __) => 'エラー',
                  loading: () => '...',
                ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        floatingActionButton: floatingActionButton,
        extendBodyBehindAppBar: true,
        body: body,
      );
    }

    if (userId == null) {
      return baseScaffold(
        const EmptyPlaceholderWidget(
          message: 'サインインが必要です。',
        ),
      );
    }

    return ref.watch(latestVotingEventStreamProvider(roomId)).when(
          data: (votingEvent) {
            final backgroundColors = _getBackGroundColors(votingEvent.status);
            final lottie = _getLottieAnimation(votingEvent.status);
            final labelText = _getTextByVotingEventStatus(votingEvent.status);
            return ref
                .watch(
                  myFeelingsProvider(
                    Tuple3(roomId, votingEvent.votingEventId, userId),
                  ),
                )
                .when(
                  data: (feelings) {
                    final hasFeeling = feelings.isNotEmpty;
                    var emoji = '';
                    if (hasFeeling) {
                      emoji = _getIconString(feelings.first.isComfortable);
                    }

                    return baseScaffold(
                      Stack(
                        children: [
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                colors: backgroundColors,
                              ),
                            ),
                            child: Center(child: lottie),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: labelText,
                                ),
                                const SizedBox(height: 100),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 24,
                            bottom: 30,
                            child: !hasFeeling
                                ? FloatingActionButton(
                                    onPressed: () => _onTapFeeling(
                                      context,
                                      ref,
                                      userId,
                                      roomId,
                                      votingEvent,
                                    ),
                                    child: const Icon(
                                      Icons.message,
                                    ),
                                  )
                                : Text(
                                    emoji,
                                    style: const TextStyle(
                                      fontSize: 60,
                                    ),
                                  ),
                          ),
                          if (votingEvent.status == VotingEventStatus.voting)
                            Stack(
                              children: [
                                Center(
                                  child: LottieBuilder.asset(
                                    'assets/lotties/fight.json',
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 48),
                                    child: ElevatedButton(
                                      onPressed: () => Navigator.of(context).pushNamed<void>(
                                        VotingPage.location(
                                          roomId: roomId,
                                          votingEventId: votingEvent.votingEventId,
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        onPrimary: Colors.black,
                                        shape: const StadiumBorder(),
                                      ),
                                      child: const Text(
                                        '投票に進む',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    );
                  },
                  error: (e, _) => baseScaffold(Text(e.toString())),
                  loading: () => const SizedBox(),
                );
          },
          error: (e, _) => Center(
            child: baseScaffold(
              Text(
                e.toString(),
              ),
            ),
          ),
          loading: () => const SizedBox(),
        );
  }

  Future<void> _onTapFeeling(
    BuildContext context,
    WidgetRef ref,
    String userId,
    String roomId,
    VotingEvent votingEvent,
  ) async {
    final isComfortable =
        await ref.read(scaffoldMessengerServiceProvider).showDialogByBuilder<bool>(
              builder: (context) => AlertDialog(
                content: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // コンテンツ領域
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text(
                        '😄',
                        style: TextStyle(fontSize: 72),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text(
                        '😣',
                        style: TextStyle(fontSize: 72),
                      ),
                    ),
                  ],
                ),
              ),
            );
    if (isComfortable == null) {
      return;
    }
    try {
      await ref.read(feelingRepositoryProvider).setFeeling(
            roomId: roomId,
            votingEventId: votingEvent.votingEventId,
            userId: userId,
            feeling: Feeling(
              userId: userId,
              isComfortable: isComfortable,
            ),
          );
      ref.refresh(
        myFeelingsProvider(
          Tuple3(roomId, votingEvent.votingEventId, userId),
        ),
      );
    } on Exception catch (e) {
      ref.read(scaffoldMessengerServiceProvider).showSnackBarByException(e);
    }
  }

  List<Color> _getBackGroundColors(VotingEventStatus status) {
    if (status == VotingEventStatus.waiting) {
      return <Color>[
        Colors.purple[600]!,
        Colors.purple[500]!,
        Colors.purple[300]!,
      ];
    }

    if (status == VotingEventStatus.voting) {
      return <Color>[
        Colors.red[600]!,
        Colors.red[500]!,
        Colors.red[300]!,
      ];
    }

    return <Color>[
      Colors.blue[600]!,
      Colors.blue[500]!,
      Colors.blue[300]!,
    ];
  }

  LottieBuilder _getLottieAnimation(VotingEventStatus status) {
    if (status == VotingEventStatus.waiting) {
      return LottieBuilder.asset('assets/lotties/waiting.json');
    }
    if (status == VotingEventStatus.voting) {
      return LottieBuilder.asset('assets/lotties/voting.json');
    }
    return LottieBuilder.asset('assets/lotties/peace.json');
  }

  Text _getTextByVotingEventStatus(VotingEventStatus status) {
    if (status == VotingEventStatus.waiting) {
      return const Text(
        'エアコンの設定温度に\n不満な人がいるようです...😒',
        style: TextStyle(color: Colors.purple, fontSize: 24),
      );
    }

    if (status == VotingEventStatus.voting) {
      return const Text(
        'エアコン戦争勃発!!!!🤯',
        style: TextStyle(color: Colors.red, fontSize: 24),
      );
    }

    return const Text(
      'みんな快適に過ごしています😌',
      style: TextStyle(color: Colors.blue, fontSize: 24),
    );
  }

  String _getIconString(bool isComfortable) {
    if (!isComfortable) {
      return '😣';
    }
    return '😄';
  }
}
