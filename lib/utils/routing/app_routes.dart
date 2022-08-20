import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../pages/about_page.dart';
import '../../pages/main_page.dart';
import '../../pages/not_found_page.dart';
import '../../pages/room_page.dart';
import '../../pages/rooms_page.dart';
import '../../pages/test_notification_page.dart';
import '../../pages/voting_page.dart';
import 'app_route.dart';
import 'app_router_state.dart';

/// AppRoute インスタンスの一覧
/// 各ページのコンストラクタに引数を渡さない済むように、そのような場合は ProviderScope.override で
/// appRouterStateProvider の値をオーバーライドして、各画面を AppState をオーバーライドされた
/// Provider 経由で取得するようにする。
final appRoutes = <AppRoute>[
  AppRoute(
    path: MainPage.path,
    name: MainPage.name,
    builder: (context, state) => const MainPage(key: ValueKey(MainPage.name)),
  ),
  AppRoute(
    path: RoomsPage.path,
    name: RoomsPage.name,
    builder: (context, state) => const RoomsPage(key: ValueKey(RoomsPage.name)),
  ),
  AppRoute(
    path: AboutPage.path,
    name: AboutPage.name,
    builder: (context, state) => const AboutPage(key: ValueKey(AboutPage.name)),
  ),
  AppRoute(
    path: RoomPage.path,
    name: RoomPage.name,
    builder: (context, state) => const RoomPage(key: ValueKey(RoomPage.name)),
  ),
  AppRoute(
    path: NotFoundPage.path,
    name: NotFoundPage.name,
    builder: (context, state) =>
        const NotFoundPage(key: ValueKey(NotFoundPage.name)),
  ),
  AppRoute(
    path: TestNotificationPage.path,
    name: TestNotificationPage.name,
    builder: (context, state) =>
        const TestNotificationPage(key: ValueKey(TestNotificationPage.name)),
  ),
  AppRoute(
    path: VotingPage.path,
    name: VotingPage.name,
    builder: (context, state) => ProviderScope(
      overrides: <Override>[appRouterStateProvider.overrideWithValue(state)],
      child: const VotingPage(key: ValueKey(VotingPage.name)),
    ),
  ),
];
