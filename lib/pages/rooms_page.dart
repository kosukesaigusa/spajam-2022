import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';
import '../features/room/room.dart';
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
      appBar: AppBar(title: const Text('ルーム一覧')),
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
                  return ListView.separated(
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: rooms.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final room = rooms[index];
                      return ListTile(
                        title: Text(room.roomName),
                        onTap: () => Navigator.pushNamed<void>(
                          context,
                          RoomPage.location(roomId: room.roomId),
                          arguments: room,
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
