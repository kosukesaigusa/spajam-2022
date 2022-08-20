import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';
import '../models/feeling.dart';
import '../repositories/firestore/feeling_repository.dart';
import '../utils/scaffold_messenger_service.dart';
import '../utils/uuid.dart';
import '../widgets/dialog.dart';
import '../widgets/empty_placeholder.dart';

/// ルームページ。
class RoomPage extends HookConsumerWidget {
  const RoomPage({super.key});

  static const path = '/rooms/:roomId';
  static const name = 'RoomPage';
  static String location({required String roomId}) => '/rooms/$roomId';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = ref.watch(userIdProvider).value;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('ルーム')),
        body: const EmptyPlaceholderWidget(
          message: 'サインインが必要です。',
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('ルーム')),
      body: Column(
        children: const [
          Text('あなたは　不快　を選択しています。'),
        ],
      ),
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
                          onPressed: () => Navigator.pop(context, false),
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
                  roomId: 'gxdmunvBcT5noyAP5FbJ',
                  votingEventId: 'pa6zlcjqr0B2jx6rL9Tg',
                  feeling: Feeling(
                    feelingId: uuid,
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
    );
  }
}
