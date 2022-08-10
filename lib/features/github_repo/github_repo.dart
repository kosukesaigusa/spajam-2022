import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/api/search_repos_response.dart';
import '../../repositories/api/repo_repository.dart';
import '../../utils/constants/number.dart';
import '../../utils/exceptions/base.dart';

/// GitHub リポジトリの検索キーワードの TextEditingController を提供する Provider。
final searchWordTextEditingControllerProvider = Provider.autoDispose<TextEditingController>(
  (ref) => TextEditingController()..text = ref.watch(searchWordProvider),
);

/// GitHub リポジトリの検索画面の ScrollController
final searchReposScrollController =
    Provider.autoDispose<ScrollController>((_) => ScrollController());

/// GitHub リポジトリの検索のページ番号を管理する StateProvider。
final searchReposPageProvider = StateProvider.autoDispose<int>((_) => 1);

/// GitHub リポジトリの検索の最大ページ番号を管理する StateProvider。
final searchReposMaxPageProvider = StateProvider.autoDispose<int?>((ref) {
  return ref.watch(searchReposResponseFutureProvider).when(
        data: (response) => response.totalCount ~/ searchReposParPage + 1,
        error: (_, __) => null,
        loading: () => null,
      );
});

/// GitHub リポジトリの検索キーワードを管理する StateProvider。
final searchWordProvider = StateProvider.autoDispose<String>((_) => 'flutter');

/// GitHub の Search Repositories API を コールし、
/// そのレスポンスを提供する FutureProvider。
final searchReposResponseFutureProvider =
    FutureProvider.autoDispose<SearchReposResponse>((ref) async {
  final q = ref.watch(searchWordTextEditingControllerProvider).value.text;
  final page = ref.watch(searchReposPageProvider);
  if (q.isEmpty) {
    throw const AppException(message: 'キーワードを入力してください。');
  }
  if (page < 1) {
    throw const AppException(message: 'ページ番号が正しくありません。');
  }
  final response = await ref.read(repoRepositoryProvider).searchRepos(q: q, page: page);
  return response;
});

/// GitHub リポジトリの検索の Pager による操作などを提供する Provider
final searchReposServiceProvider = Provider.autoDispose<SearchReposService>(SearchReposService.new);

class SearchReposService {
  SearchReposService(this._ref);

  final AutoDisposeProviderRef<SearchReposService> _ref;

  /// 検索ワードを変更したときなどに、ページ番号やスクロール位置などをリセットして
  /// searchReposResponseFutureProvider をリフレッシュする。
  void refresh() {
    _ref.read(searchReposPageProvider.notifier).update((state) => 1);
    _animateToTop();
    _ref.refresh(searchReposResponseFutureProvider);
  }

  /// 前のページが存在していれば表示する。
  void showPreviousPage(int? previousPageNumber) {
    if (previousPageNumber == null) {
      return;
    }
    _ref.read(searchReposPageProvider.notifier).update((state) => previousPageNumber);
    _animateToTop();
  }

  /// 次のページが存在していれば表示する。
  void showNextPage(int? nextPageNumber) {
    if (nextPageNumber == null) {
      return;
    }
    _ref.read(searchReposPageProvider.notifier).update((state) => nextPageNumber);
    _animateToTop();
  }

  /// スクロール位置を上に戻す。
  void _animateToTop() {
    final sc = _ref.read(searchReposScrollController);
    if (!sc.hasClients) {
      return;
    }
    sc.animateTo(
      0,
      duration: const Duration(microseconds: 200),
      curve: Curves.linear,
    );
  }
}
