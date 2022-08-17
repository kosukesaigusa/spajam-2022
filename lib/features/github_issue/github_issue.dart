import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../repositories/api/issue_repository.dart';
import '../../utils/loading.dart';
import '../../utils/scaffold_messenger_service.dart';

/// [IssueRepository] の createIssue() をコールして、
///
/// リクエストの成否に応じたメッセージをスナックバーに表示する関数を提供する Provider。
final createIssueProvider = Provider<
    Future<void> Function({
  required String comment,
  required String title,
  required VoidCallback onSuccess,
})>(
  (ref) {
    return ({
      required title,
      required comment,
      required onSuccess,
    }) async {
      try {
        ref.read(overlayLoadingProvider.notifier).update((state) => true);
        await ref.read(issueRepositoryProvider).createIssue(
              title: title,
              comment: comment,
            );
        onSuccess();
        ref.read(scaffoldMessengerServiceProvider).showSnackBar('Issue を作成しました。');
      } on Exception catch (e) {
        ref.read(scaffoldMessengerServiceProvider).showSnackBarByException(e);
      } finally {
        ref.read(overlayLoadingProvider.notifier).update((state) => false);
      }
    };
  },
);
