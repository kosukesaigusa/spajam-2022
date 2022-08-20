enum VoteEnum {
  extremelyHot('めちゃ暑い'),
  hot('暑い'),
  comfortable('快適'),
  cold('寒い'),
  extremelyCold('めちゃ寒い');

  const VoteEnum(this.label);

  /// 表示ラベル。
  final String label;
}
