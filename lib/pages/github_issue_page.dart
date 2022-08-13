import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../utils/extensions/build_context.dart';

class GitHubIssuePage extends HookConsumerWidget {
  const GitHubIssuePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleController = useTextEditingController();
    final commentController = useTextEditingController();
    final titleFieldEmpty = useState<bool>(true);
    final commentFieldEmpty = useState<bool>(true);

    bool _titleFieldEmpty() => titleController.text.isEmpty;
    bool _commentFieldEmpty() => commentController.text.isEmpty;

    useEffect(
      () {
        titleController.addListener(
          () => titleFieldEmpty.value = _titleFieldEmpty(),
        );
        commentController.addListener(
          () => commentFieldEmpty.value = _commentFieldEmpty(),
        );
        return null;
      },
      [
        titleController,
        commentController,
      ],
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
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
                  onPressed: !titleFieldEmpty.value || !commentFieldEmpty.value
                      ? () {
                          titleController.clear();
                          commentController.clear();
                        }
                      : null,
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
                  onPressed: !commentFieldEmpty.value && !titleFieldEmpty.value
                      ? () {
                          // TODO(shimizu-saffle): issueを作成する
                        }
                      : null,
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
            controller: titleController,
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
                controller: commentController,
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
