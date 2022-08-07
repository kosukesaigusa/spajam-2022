import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GitHubReposPage extends HookConsumerWidget {
  const GitHubReposPage({super.key});

  static const path = '/repos';
  static const name = 'GitHubReposPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('GitHub Repose')),
      body: const SizedBox(),
    );
  }
}
