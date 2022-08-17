import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/empty_placeholder.dart';

class TestNotificationPage extends StatelessWidget {
  const TestNotificationPage({super.key});

  static const path = '/testNotification';
  static const name = 'TestNotificationPage';
  static const location = path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('テスト通知の受けページ')),
      body: const EmptyPlaceholderWidget(
        widget: FaIcon(FontAwesomeIcons.bell, size: 48),
        message: 'このページはテスト通知の受けページです',
      ),
    );
  }
}
