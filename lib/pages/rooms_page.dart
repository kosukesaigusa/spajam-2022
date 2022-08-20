import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';
import '../features/room/room.dart';
import '../features/voting_event/voting_event.dart';
import '../utils/extensions/build_context.dart';
import '../utils/loading.dart';
import '../widgets/empty_placeholder.dart';
import 'room_page.dart';

/// ルーム一覧ページ
class RoomsPage extends HookConsumerWidget {
  const RoomsPage({super.key});

  static const path = '/rooms';
  static const name = 'RoomsPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider).value;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SPAJAM 株式会社',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: userId == null
          ? const EmptyPlaceholderWidget(
              message: '（仮）ルーム一覧を表示するにはサインインが必要です。'
                  '「About > 匿名サインイン」から匿名でのサインインを行ってください。',
            )
          : ref.watch(roomsStreamProvider).when(
                data: (rooms) {
                  if (rooms.isEmpty) {
                    return const EmptyPlaceholderWidget(
                      widget: FaIcon(
                        FontAwesomeIcons.list,
                        color: Colors.black45,
                        size: 48,
                      ),
                      message: 'Room がありません。'
                          'Room を作成してください。',
                    );
                  }
                  return GridView.builder(
                    shrinkWrap: true,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    itemCount: rooms.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final room = rooms[index];
                      final votingEventMood =
                          ref.watch(latestVotingEventStreamProvider(room.roomId)).when(
                                data: (data) => Text(
                                  data.status.mood,
                                  style: const TextStyle(
                                    fontSize: 70,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                error: (_, __) => const SizedBox(),
                                loading: () => const PrimarySpinkitCircle(),
                              );
                      return InkWell(
                        onTap: () => Navigator.pushNamed<void>(
                          context,
                          RoomPage.location(roomId: room.roomId),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 8,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: context.displaySize.width * 0.3,
                                child: Center(
                                  child: votingEventMood,
                                ),
                              ),
                              Text(
                                room.roomName,
                                style: context.textTheme.headline6,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                error: (_, __) => const SizedBox(),
                loading: () => const PrimarySpinkitCircle(),
              ),
    );
  }
}
