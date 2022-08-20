import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters/union_timestamp.dart';
import 'voting_event.dart';

part 'rooms.freezed.dart';
part 'rooms.g.dart';

@freezed
class Rooms with _$Rooms {
  const factory Rooms({
    @Default('') String roomId,
    @Default('') String roomName,
    @unionTimestampConverter @Default(UnionTimestamp.serverTimestamp()) UnionTimestamp createdAt,
    @Default(<String>[]) List<String> userIds,
    @Default(<VotingEvent>[]) List<VotingEvent> votingEvent,
  }) = _Rooms;

  factory Rooms.fromJson(Map<String, dynamic> json) => _$RoomsFromJson(json);

  static const defaultValue = Rooms();
}
