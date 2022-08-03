import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../features/auth/auth.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({super.key});

  static const path = '/signIn';
  static const name = 'SignInPage';
  static const location = path;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('サインイン')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => ref.read(signInAnonymouslyProvider)(),
                child: const Text('匿名サインイン'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
