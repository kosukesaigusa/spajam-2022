import 'package:flutter/material.dart';

enum VoteEnum {
  extremelyHot('めちゃ暑い','🥵', Colors.red,),
  hot('暑い', '💦',Colors.amber),
  comfortable('快適','🍀', Colors.green),
  cold('寒い','🍃' , Colors.cyan),
  extremelyCold('めちゃ寒い','🥶', Colors.blue);

  const VoteEnum(this.label, this.emoji, this.color);

  /// 表示ラベル。
  final String label;
  final String emoji;
  final Color color;
}
