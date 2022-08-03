import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:spajam2022/pages/root_navigator.dart';

class App extends ConsumerWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const RootNavigator(),
      builder: (context, child) {
        return MediaQuery(
          // 端末依存のフォントスケールを 1 に固定
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
          child: child!,
        );
      },
    );
  }
}
