import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'github_issue_page.dart';
import 'github_repos_page.dart';

class GitHubPage extends HookWidget {
  const GitHubPage({super.key});

  static const path = '/github';
  static const name = 'GitHubPage';
  static const location = path;

  @override
  Widget build(BuildContext context) {
    final tabController = useTabController(initialLength: 2);
    return Scaffold(
      appBar: AppBar(
        title: const Text('GitHub'),
        bottom: TabBar(
          controller: tabController,
          tabs: const <Widget>[
            Tab(text: 'Repo Search'),
            Tab(text: 'Create Issue'),
          ],
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: TabBarView(
          controller: tabController,
          children: const [
            GitHubReposPage(),
            GitHubIssuePage(),
          ],
        ),
      ),
    );
  }
}
