import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spajam2022/features/auth/auth.dart';
import 'package:spajam2022/pages/about_page.dart';
import 'package:spajam2022/pages/sign_in_page.dart';

import '../utils/loading.dart';

/// ウィジェットツリーの上位にある Navigator を含むウィジェット。
class RootNavigator extends HookConsumerWidget {
  const RootNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            // Navigator(
            //   key: ref.watch(globalKeyProvider),
            //   initialRoute: ref.watch(appRouterProvider).initialRoute,
            //   onGenerateRoute: ref.watch(appRouterProvider).onGenerateRoute,
            //   onUnknownRoute: (settings) {
            //     final route = MaterialPageRoute<void>(
            //       settings: settings,
            //       builder: (context) => const NotFoundPage(),
            //     );
            //     return route;
            //   },
            // ),
            ref.watch(userIdProvider).when(
                  data: (userId) => userId == null ? const SignInPage() : const AboutPage(),
                  error: (_, __) => const SizedBox(),
                  loading: () => const SizedBox(),
                ),
            if (ref.watch(overlayLoadingProvider)) const OverlayLoadingWidget(),
          ],
        ),
      ),
    );
  }
}
