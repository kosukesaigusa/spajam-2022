import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/api/post_issue_response.dart';
import '../../utils/api/api_client.dart';
import '../../utils/exceptions/base.dart';

final issueRepositoryProvider = Provider.autoDispose(
  (ref) => IssueRepository(ref.read(apiClientProvider)),
);

class IssueRepository {
  IssueRepository(this._client);
  final ApiClient _client;

  /// POST repos/KosukeSaigusa/spajam-2022/issues API をコールして、
  /// リポジトリに Issue を作成する。
  Future<PostIssueResponse> createIssue({
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
    return responseResult.when<PostIssueResponse>(
      success: PostIssueResponse.fromBaseResponseData,
      failure: (message) => throw AppException(message: message),
    );
  }
}
