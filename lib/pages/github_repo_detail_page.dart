import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/github_repo.dart';
import '../repositories/api/repo_repository.dart';
import '../utils/exceptions/base.dart';
import '../utils/routing/app_router_state.dart';
import '../widgets/github_repo.dart';

/// AppRouterState.extra に Repo インスタンスが見つかればそれを、
/// 見つからなければ、AppRouterState.params（パスパラメータ）から得られる
/// owner (String), repo (String) を用いて GET Repository API をコールして、
/// Repo インスタンスを取得してから返す FutureProvider。
final repoFutureProvider = FutureProvider.autoDispose<Repo>(
  (ref) async {
    final repo = ref.read(extractExtraDataProvider)<Repo>();
    if (repo != null) {
      return repo;
    }
    try {
      final state = ref.read(appRouterStateProvider);
      final owner = state.params['owner']!;
      final repo = state.params['repo']!;
      final fetchRepoResponse =
          await ref.read(repoRepositoryProvider).fetchRepo(owner: owner, repo: repo);
      return fetchRepoResponse.repo;
    } on Exception {
      throw const AppException(message: '指定したリポジトリは見つかりませんでした。');
    }
  },
  // dependencies の明示が必要
  dependencies: <ProviderOrFamily>[
    extractExtraDataProvider,
    appRouterStateProvider,
    repoRepositoryProvider,
  ],
);

/// リポジトリの詳細ページ。
class GitHubRepoDetailPage extends HookConsumerWidget {
  const GitHubRepoDetailPage({super.key});

  static const path = '/repo/:owner/:repo';
  static const name = 'GitHubRepoRepoDetailPage';
  static String location({required String owner, required String repo}) => '/repo/$owner/$repo';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Repo Detail')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ref.watch(repoFutureProvider).when<Widget>(
              data: (repo) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: RepoItem(repo: repo),
              ),
              error: (_, __) => const SizedBox(),
              loading: () => RepoItem.shimmer,
            ),
      ),
    );
  }
}
