import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';
import 'voting_event.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    @Default('') String roomId,
    @Default('') String roomName,
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
    @Default(<String>[]) List<String> userIds,
    @Default(<VotingEvent>[]) List<VotingEvent> votingEvents,
  }) = _Rooms;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);

  factory Room.fromDocumentSnapshot(DocumentSnapshot ds) {
    final data = ds.data()! as Map<String, dynamic>;
    return Room.fromJson(<String, dynamic>{
      ...data,
      'roomId': ds.id,
    });
  }

  static const defaultValue = Room();
}