import 'package:flutter/scheduler.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/api/issue_repository.dart';
import '../../utils/scaffold_messenger_service.dart';

/// [IssueRepository] の createIssue() をコールして、
///
/// リクエストの成否に応じたメッセージをスナックバーに表示する関数を提供する Provider。
///
/// String: Issue のタイトル
///
/// String: Issue のコメント
///
/// VoidCallback: リクエスト成功時のコールバック
final createIssueProvider = Provider<void Function(String, String, VoidCallback)>(
  (ref) {
    return (title, comment, onSuccess) async {
      try {
        await ref.read(issueRepositoryProvider).createIssue(
              title: title,
              comment: comment,
            );
        onSuccess();
        ref.read(scaffoldMessengerServiceProvider).showSnackBar('Issue を作成しました。');
      } on Exception catch (e) {
        ref.read(scaffoldMessengerServiceProvider).showSnackBarByException(e);
      }
    };
  },
);
