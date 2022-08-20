import 'package:flutter/material.dart';

enum VoteEnum {
  extremelyHot(
    label: 'めちゃ暑い',
    emoji: '🥵',
    color: Colors.red,
    resultText: 'めちゃ暑い人の気持ちが尊重されました!\nエアコンの設定温度を\n2度下げてください📉',
  ),
  hot(
    label: '暑い',
    emoji: '💦',
    color: Colors.amber,
    resultText: '暑い人の気持ちが尊重されました!\nエアコンの設定温度を\n1度下げてください📉',
  ),
  comfortable(
    label: '快適',
    emoji: '🍀',
    color: Colors.green,
    resultText: '快適な気持ちが尊重されました!\nエアコンの設定温度は\nそのままで大丈夫です🙆',
  ),
  cold(
    label: '寒い',
    emoji: '🍃',
    color: Colors.cyan,
    resultText: '寒い人の気持ちが尊重されました!\nエアコンの設定温度を\n1度上げてください📈',
  ),
  extremelyCold(
    label: 'めちゃ寒い',
    emoji: '🥶',
    color: Colors.blue,
    resultText: 'めちゃ寒い人の気持ちが尊重されました!\nエアコンの設定温度を\n2度上げてください📈',
  );

  const VoteEnum({
    required this.label,
    required this.emoji,
    required this.color,
    required this.resultText,
  });

  /// 表示ラベル。
  final String label;

  /// 表示絵文字
  final String emoji;

  /// ボタンカラー
  final Color color;

  /// エアコン戦争の結果に応じて画面に表示するテキスト
  final String resultText;
}
