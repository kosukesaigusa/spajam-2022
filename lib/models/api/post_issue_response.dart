import 'package:freezed_annotation/freezed_annotation.dart';

import '../github_issue.dart';
import 'base_response_data.dart';

part 'post_issue_response.freezed.dart';
part 'post_issue_response.g.dart';

@freezed
class PostIssueResponse with _$PostIssueResponse {
  const factory PostIssueResponse({
    @Default(true) bool success,
    @Default('') String message,
    @Default(Issue.defaultValue) Issue issue,
  }) = _PostIssueResponse;

  factory PostIssueResponse.fromJson(Map<String, dynamic> json) =>
      _$PostIssueResponseFromJson(json);

  factory PostIssueResponse.fromBaseResponseData(
    BaseResponseData baseResponseData,
  ) =>
      PostIssueResponse.fromJson(
        <String, dynamic>{
          'success': baseResponseData.success,
          'message': baseResponseData.message,
          'issue': baseResponseData.data,
        },
      );
}
