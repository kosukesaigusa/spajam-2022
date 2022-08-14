import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../utils/api/api_client.dart';
import '../../utils/exceptions/base.dart';
import '../../utils/logger.dart';

final issueRepositoryProvider = Provider.autoDispose(
  (ref) => IssueRepository(ref.read(apiClientProvider)),
);

class IssueRepository {
  IssueRepository(this._client);
  final ApiClient _client;

  /// POST repos/KosukeSaigusa/spajam-2022/issues API をコールして、
  /// リポジトリに Issue を作成する。
  Future<void> createIssue({
    required String title,
    required String comment,
  }) async {
    final responseResult = await _client.post(
      '/repos/KosukeSaigusa/spajam-2022/issues',
      data: <String, dynamic>{
        'title': title,
        'body': comment,
      },
    );
    responseResult.when<void>(
      success: (data) => logger.info('$data'),
      failure: (message) => throw AppException(message: message),
    );
  }
}
