import 'package:flutter/material.dart';

class TestNotificationPage extends StatelessWidget {
  const TestNotificationPage({super.key});

  static const path = '/testNotification';
  static const name = 'TestNotificationPage';
  static const location = path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('通知テスト')),
      body: const SizedBox(),
    );
  }
}
