import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/github_repo/github_repo.dart';
import '../models/api/search_repos_response.dart';
import '../models/github_repo.dart';
import '../utils/constants/style.dart';
import '../utils/extensions/build_context.dart';
import '../utils/extensions/int.dart';
import '../widgets/empty_placeholder.dart';
import '../widgets/github_repo.dart';
import '../widgets/pager.dart';
import '../widgets/shimmer.dart';
import 'github_repo_detail_page.dart';

/// GitHub のリポジトリ一覧ページ。
class GitHubReposPage extends HookConsumerWidget {
  const GitHubReposPage({super.key});

  static const path = '/repos';
  static const name = 'GitHubReposPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Repos')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SearchTextField(),
          ),
          if (ref.watch(searchReposResponseFutureProvider).isLoading) ...[
            const Gap(8),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: ShimmerWidget.rectangular(width: 200, height: 18),
            ),
            const Gap(8),
            _dividerWithShadow,
            const Expanded(child: GitHubReposListView.shimmer())
          ] else
            ...ref.watch(searchReposResponseFutureProvider).when(
                  data: (response) {
                    final repos = response.repos;
                    return [
                      if (ref.watch(searchReposMaxPageProvider) != null) ...[
                        const Gap(8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SearchResultText(response: response),
                        ),
                        const Gap(8),
                        _dividerWithShadow,
                      ],
                      Expanded(child: GitHubReposListView(repos: repos)),
                    ];
                  },
                  error: (e, __) => [
                    Expanded(
                      child: EmptyPlaceholderWidget(
                        widget:
                            const FaIcon(FontAwesomeIcons.github, color: Colors.black45, size: 48),
                        message: e.toString(),
                      ),
                    ),
                  ],
                  loading: () => [
                    const Expanded(child: GitHubReposListView.shimmer()),
                  ],
                ),
        ],
      ),
    );
  }

  /// 検索テキストフィールドと Repo 一覧の間の影付き Divider。
  Widget get _dividerWithShadow => Builder(
        builder: (context) {
          return Container(
            height: 1,
            decoration: BoxDecoration(
              color: context.theme.dividerColor,
              boxShadow: [
                BoxShadow(
                  color: context.theme.highlightColor,
                  spreadRadius: 1,
                  blurRadius: 1,
                ),
              ],
            ),
          );
        },
      );
}

/// 検索結果の件数、現在のページ数、最大ページ数を表示する RichText。
class SearchResultText extends HookConsumerWidget {
  const SearchResultText({
    super.key,
    required this.response,
  });

  final SearchReposResponse response;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalCount = response.totalCount;
    return RichText(
      text: TextSpan(
        style: context.bodySmall,
        children: [
          TextSpan(
            text: '${totalCount.withComma} 件 ',
          ),
          TextSpan(
            text: '（${ref.watch(searchReposPageProvider).withComma} / ',
          ),
          TextSpan(
            text: '${ref.watch(searchReposMaxPageProvider)!.withComma} ページ）',
          ),
        ],
      ),
    );
  }
}

/// GitHub リポジトリの検索結果の ListView.builder。
/// 最下部には Pager ウィジェットも表示する。
class GitHubReposListView extends HookConsumerWidget {
  const GitHubReposListView({
    super.key,
    required this.repos,
  }) : shimmer = false;

  const GitHubReposListView.shimmer({
    super.key,
  })  : repos = const [],
        shimmer = true;

  final List<Repo> repos;
  final bool shimmer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPager = (ref.watch(searchReposMaxPageProvider) ?? 0) > 1;
    if (shimmer) {
      return ListView.builder(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 8,
          bottom: 32,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => RepoItem.shimmer,
      );
    }
    return ListView.builder(
      controller: ref.watch(searchReposScrollController),
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 32,
      ),
      itemCount: showPager ? repos.length + 1 : repos.length,
      itemBuilder: (context, index) {
        if (index < repos.length) {
          final repo = repos[index];
          return RepoItem(
            repo: repo,
            onTap: () => Navigator.pushNamed<void>(
              context,
              GitHubRepoDetailPage.location(
                owner: repo.owner.login,
                repo: repo.name,
              ),
              // ここでは Repo インスタンスをルート引数に指定しているので、
              // RepoDetailPage では GET Repo API はコールされない。
              arguments: repo,
            ),
          );
        } else {
          final hasPrevious = ref.watch(searchReposPageProvider) > 1;
          final hasNext =
              (ref.watch(searchReposMaxPageProvider) ?? 0) > ref.watch(searchReposPageProvider);
          return Padding(
            padding: const EdgeInsets.only(top: 16),
            child: PagerWidget(
              hasPrevious: hasPrevious,
              hasNext: hasNext,
              previousPageNumber: ref.watch(searchReposPageProvider) - 1,
              nextPageNumber: ref.watch(searchReposPageProvider) + 1,
              onPreviousButtonTapped: () => ref
                  .read(searchReposServiceProvider)
                  .showPreviousPage(ref.watch(searchReposPageProvider) - 1),
              onNextButtonTapped: () => ref
                  .read(searchReposServiceProvider)
                  .showNextPage(ref.watch(searchReposPageProvider) + 1),
            ),
          );
        }
      },
    );
  }
}

/// GitHub リポジトリの検索キーワードの TextField。
class SearchTextField extends HookConsumerWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      textInputAction: TextInputAction.search,
      controller: ref.watch(searchWordTextEditingControllerProvider),
      style: context.titleMedium,
      cursorWidth: 1,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search, color: Colors.black26, size: 24),
        prefixIconConstraints: const BoxConstraints(minWidth: 36, maxWidth: 36),
        suffixIcon: GestureDetector(
          onTap: () {
            ref.read(searchWordTextEditingControllerProvider).clear();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: const Icon(
            Icons.clear,
            color: Colors.black26,
            size: 24,
          ),
        ),
        suffixIconConstraints: const BoxConstraints(minWidth: 36, maxWidth: 36),
        contentPadding: const EdgeInsets.all(8),
        isDense: true,
        filled: true,
        fillColor: Colors.grey[100],
        hintText: 'キーワードで検索',
        hintStyle: context.bodyMedium!.copyWith(color: Colors.black26),
        disabledBorder: searchTextFieldBorder,
        enabledBorder: searchTextFieldBorder,
        errorBorder: searchTextFieldBorder,
        focusedErrorBorder: searchTextFieldBorder,
        focusedBorder: searchTextFieldBorder,
        border: searchTextFieldBorder,
      ),
      onSubmitted: (q) async {
        ref.read(searchReposServiceProvider).refresh();
      },
    );
  }
}
