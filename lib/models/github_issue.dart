import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_issue.freezed.dart';
part 'github_issue.g.dart';

@freezed
class Issue with _$Issue {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory Issue({
    @Default(0) int id,
    @Default(0) int number,
    @Default('') String title,
    @Default('') String htmlUrl,
    @Default('') String state,
    @Default('') String description,
    @Default('') String body,
    @Default(0) int comments,
    String? assignee,
    List<String>? assignees,
    DateTime? updatedAt,
    DateTime? closedAt,
  }) = _GithubIssue;

  factory Issue.fromJson(Map<String, dynamic> json) => _$IssueFromJson(json);

  static const defaultValue = Issue();
}
