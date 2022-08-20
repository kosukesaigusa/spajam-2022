import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';

part 'feeling.freezed.dart';
part 'feeling.g.dart';

@freezed
class Feeling with _$Feeling {
  const factory Feeling({
    @Default('') String feelingId,
    @Default('') String userId,
    @Default(true) bool isComfortable,
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
  }) = _Feeling;

  factory Feeling.fromJson(Map<String, dynamic> json) => _$FeelingFromJson(json);

  static const defaultValue = Feeling();
}
