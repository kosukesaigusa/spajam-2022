import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';

part 'complete_voting_request.freezed.dart';
part 'complete_voting_request.g.dart';

@freezed
class CompleteVotingRequest with _$CompleteVotingRequest {
  const factory CompleteVotingRequest({
    @Default('') String userId,
    @Default('') String completeVotingRequestId,
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
  }) = _CompleteVotingRequest;

  factory CompleteVotingRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteVotingRequestFromJson(json);

  factory CompleteVotingRequest.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return CompleteVotingRequest.fromJson(<String, dynamic>{
      ...data,
      'completeVotingRequestId': ds.id,
    });
  }

  const CompleteVotingRequest._();
}
