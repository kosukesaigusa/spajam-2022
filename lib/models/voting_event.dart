import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';
import 'feeling.dart';
import 'vote.dart';
import 'vote_enum.dart';
import 'voting_event_status.dart';

part 'voting_event.freezed.dart';
part 'voting_event.g.dart';

@freezed
class VotingEvent with _$VotingEvent {
  factory VotingEvent({
    @Default('') String votingEventId,
    @Default(<String>[]) List<String> votingUserIds,
    @Default(VotingEventStatus.peace) VotingEventStatus status,
    @Default(VoteEnum.comfortable) VoteEnum result,
    @Default(<Feeling>[]) List<Feeling> feelings,
    @Default(<Vote>[]) List<Vote> votes,
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
  }) = _VotingEvent;

  factory VotingEvent.fromJson(Map<String, dynamic> json) => _$VotingEventFromJson(json);

  factory VotingEvent.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return VotingEvent.fromJson(<String, dynamic>{
      ...data,
      'votingEventId': ds.id,
    });
  }
}
