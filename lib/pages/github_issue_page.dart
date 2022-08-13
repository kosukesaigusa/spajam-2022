import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/extensions/build_context.dart';

class GitHubIssuePage extends HookConsumerWidget {
  const GitHubIssuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          const Gap(8),
          Text(
            'Create a new Issue on KosukeSaigusa/spajam-2022',
            style: context.displaySmall,
          ),
          const Gap(8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: context.displaySize.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO(shimizu-saffle): TextFieldをクリアする
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                width: context.displaySize.width * 0.4,
                child: ElevatedButton(
                  onPressed: () {
                    // TODO(shimizu-saffle): issueを作成する
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green.shade500,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(32),
                      ),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
          const Gap(8),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Title',
              hintStyle: context.headlineMedium,
              border: InputBorder.none,
            ),
          ),
          SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(height: context.displaySize.height * 0.6),
              child: TextFormField(
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: 'Leave a comment',
                  hintStyle: context.headlineSmall,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
