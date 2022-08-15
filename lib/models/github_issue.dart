import 'package:freezed_annotation/freezed_annotation.dart';

part 'github_issue.freezed.dart';
part 'github_issue.g.dart';

@freezed
class GithubIssue with _$GithubIssue {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GithubIssue({
    required int id,
    required int number,
    required String title,
    required String htmlUrl,
    required String state,
    @Default('') String description,
    @Default('') String body,
    @Default(0) int comments,
    String? assignee,
    List<String>? assignees,
    DateTime? updatedAt,
    DateTime? closedAt,
  }) = _GithubIssue;

  factory GithubIssue.fromJson(Map<String, dynamic> json) => _$GithubIssueFromJson(json);
}
