import 'package:flutter/material.dart';

enum VoteEnum {
  extremelyHot(
    label: 'めちゃ暑い',
    emoji: '🥵',
    color: Colors.red,
  ),
  hot(
    label: '暑い',
    emoji: '💦',
    color: Colors.amber,
  ),
  comfortable(
    label: '快適',
    emoji: '🍀',
    color: Colors.green,
  ),
  cold(
    label: '寒い',
    emoji: '🍃',
    color: Colors.cyan,
  ),
  extremelyCold(
    label: 'めちゃ寒い',
    emoji: '🥶',
    color: Colors.blue,
  );

  const VoteEnum({
    required this.label,
    required this.emoji,
    required this.color,
  });

  /// 表示ラベル。
  final String label;
  /// 表示絵文字
  final String emoji;
  /// ボタンカラー
  final Color color;
}
