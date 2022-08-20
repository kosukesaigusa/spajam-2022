import 'package:freezed_annotation/freezed_annotation.dart';

import 'vote_enum.dart';

part 'vote.freezed.dart';
part 'vote.g.dart';

@freezed
class Vote with _$Vote {
  factory Vote({
    @Default('') String voteId,
    @Default('') String userId,
    VoteEnum? vote,
  }) = _Vote;

  factory Vote.fromJson(Map<String, dynamic> json) => _$VoteFromJson(json);
}
