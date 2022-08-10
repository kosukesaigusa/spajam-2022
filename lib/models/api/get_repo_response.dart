import 'package:freezed_annotation/freezed_annotation.dart';

import '../github_repo.dart';
import 'base_response_data.dart';

part 'get_repo_response.freezed.dart';
part 'get_repo_response.g.dart';

@freezed
class GetRepoResponse with _$GetRepoResponse {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory GetRepoResponse({
    @Default(true) bool success,
    @Default('') String message,
    @Default(Repo.defaultValue) Repo repo,
  }) = _GetRepoResponse;

  factory GetRepoResponse.fromJson(Map<String, dynamic> json) => _$GetRepoResponseFromJson(json);

  factory GetRepoResponse.fromBaseResponseData(
    BaseResponseData baseResponseData,
  ) =>
      GetRepoResponse.fromJson(
        <String, dynamic>{
          'success': baseResponseData.success,
          'message': baseResponseData.message,
          'repo': baseResponseData.data,
        },
      );
}
