import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/api/get_repo_response.dart';
import '../../models/api/search_repos_response.dart';
import '../../utils/api/api_client.dart';
import '../../utils/constants/number.dart';
import '../../utils/exceptions/base.dart';

final repoRepositoryProvider = Provider.autoDispose(
  (ref) => RepoRepository(ref.read(apiClientProvider)),
);

class RepoRepository {
  RepoRepository(this._client);
  final ApiClient _client;

  /// 入力したキーワードで GET /search/repositories API をコールして、
  /// ヒットする GitHub リポジトリ一覧を含む SearchReposResponse を返す。
  Future<SearchReposResponse> searchRepos({
    required String q,
    int page = 1,
  }) async {
    final responseResult = await _client.get(
      '/search/repositories',
      queryParameters: <String, dynamic>{
        'q': q,
        'page': page,
        'per_page': searchReposParPage,
      },
    );
    return responseResult.when<SearchReposResponse>(
      success: SearchReposResponse.fromBaseResponseData,
      failure: (message) => throw AppException(message: message),
    );
  }

  /// GET /repos/{owner}/{repo} API をコールして指定した GitHub リポジトリを取得する。
  Future<GetRepoResponse> fetchRepo({
    required String owner,
    required String repo,
  }) async {
    final responseResult = await _client.get('/repos/$owner/$repo');
    return responseResult.when<GetRepoResponse>(
      success: GetRepoResponse.fromBaseResponseData,
      failure: (message) => throw AppException(message: message),
    );
  }
}
