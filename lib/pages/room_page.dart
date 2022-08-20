import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';
import '../features/voting_event/voting_event.dart';
import '../models/feeling.dart';
import '../repositories/firestore/feeling_repository.dart';
import '../utils/exceptions/base.dart';
import '../utils/loading.dart';
import '../utils/routing/app_router_state.dart';
import '../utils/scaffold_messenger_service.dart';
import '../widgets/dialog.dart';
import '../widgets/empty_placeholder.dart';

/// VotingPageArguments インスタンスを取得してから返す Provider。
final roomPageArgumentsProvider = Provider.autoDispose<String>(
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
    final roomId = ref.watch(roomPageArgumentsProvider);

    Widget baseScaffold(Widget body, {Widget? floatingActionButton}) {
      return Scaffold(
        appBar: AppBar(title: const Text('ルーム')),
        floatingActionButton: floatingActionButton,
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

    return ref.watch(votingEventStreamProvider(roomId)).when(
          data: (votingEvent) => Center(
            child: baseScaffold(
              Text(votingEvent.toString()),
              floatingActionButton: FloatingActionButton(
                onPressed: () async {
                  // 後でお手製
                  final isComfortable = await ref
                      .read(scaffoldMessengerServiceProvider)
                      .showDialogByBuilder<bool>(
                        builder: (context) => AlertDialog(
                          content: CommonAlertDialogContent(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // コンテンツ領域
                                SimpleDialogOption(
                                  onPressed: () => Navigator.pop(context, true),
                                  child: const Text('快適'),
                                ),
                                SimpleDialogOption(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('不快'),
                                ),
                              ],
                            ),
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
                  } on Exception catch (e) {
                    ref
                        .read(scaffoldMessengerServiceProvider)
                        .showSnackBarByException(e);
                  }
                },
                child: const Icon(
                  Icons.message,
                ),
              ),
            ),
          ),
          error: (e, _) => Center(
            child: baseScaffold(Text(e.toString())),
          ),
          loading: () =>
              baseScaffold(const Center(child: PrimarySpinkitCircle())),
        );
  }
}
