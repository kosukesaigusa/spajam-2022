import 'package:freezed_annotation/freezed_annotation.dart';

import '../../utils/constants/string.dart';
import 'base_response_data.dart';

part 'response_result.freezed.dart';

@freezed
class ResponseResult with _$ResponseResult {
  /// 成功
  const factory ResponseResult.success({
    required BaseResponseData data,
  }) = Success;

  /// 失敗
  const factory ResponseResult.failure({
    @Default(serverConnectionFailure) String message,
  }) = Failure;
}
