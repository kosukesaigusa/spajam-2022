// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Rooms.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get roomId => throw _privateConstructorUsedError;
  String get roomName => throw _privateConstructorUsedError;
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;
  List<String> get userIds => throw _privateConstructorUsedError;
  List<VotingEvent> get votingEvents => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res>;
  $Res call(
      {String roomId,
      String roomName,
      @unionTimestampConverter UnionTimestamp createdAt,
      List<String> userIds,
      List<VotingEvent> votingEvents});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$RoomCopyWithImpl<$Res> implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  final Room _value;
  // ignore: unused_field
  final $Res Function(Room) _then;

  @override
  $Res call({
    Object? roomId = freezed,
    Object? roomName = freezed,
    Object? createdAt = freezed,
    Object? userIds = freezed,
    Object? votingEvents = freezed,
  }) {
    return _then(_value.copyWith(
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      userIds: userIds == freezed
          ? _value.userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      votingEvents: votingEvents == freezed
          ? _value.votingEvents
          : votingEvents // ignore: cast_nullable_to_non_nullable
              as List<VotingEvent>,
    ));
  }

  @override
  $UnionTimestampCopyWith<$Res> get createdAt {
    return $UnionTimestampCopyWith<$Res>(_value.createdAt, (value) {
      return _then(_value.copyWith(createdAt: value));
    });
  }
}

/// @nodoc
abstract class _$$_RoomsCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$_RoomsCopyWith(_$_Rooms value, $Res Function(_$_Rooms) then) =
      __$$_RoomsCopyWithImpl<$Res>;
  @override
  $Res call(
      {String roomId,
      String roomName,
      @unionTimestampConverter UnionTimestamp createdAt,
      List<String> userIds,
      List<VotingEvent> votingEvents});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$_RoomsCopyWithImpl<$Res> extends _$RoomCopyWithImpl<$Res>
    implements _$$_RoomsCopyWith<$Res> {
  __$$_RoomsCopyWithImpl(_$_Rooms _value, $Res Function(_$_Rooms) _then)
      : super(_value, (v) => _then(v as _$_Rooms));

  @override
  _$_Rooms get _value => super._value as _$_Rooms;

  @override
  $Res call({
    Object? roomId = freezed,
    Object? roomName = freezed,
    Object? createdAt = freezed,
    Object? userIds = freezed,
    Object? votingEvents = freezed,
  }) {
    return _then(_$_Rooms(
      roomId: roomId == freezed
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomName: roomName == freezed
          ? _value.roomName
          : roomName // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
      userIds: userIds == freezed
          ? _value._userIds
          : userIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      votingEvents: votingEvents == freezed
          ? _value._votingEvents
          : votingEvents // ignore: cast_nullable_to_non_nullable
              as List<VotingEvent>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Rooms implements _Rooms {
  const _$_Rooms(
      {this.roomId = '',
      this.roomName = '',
      @unionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp(),
      final List<String> userIds = const <String>[],
      final List<VotingEvent> votingEvents = const <VotingEvent>[]})
      : _userIds = userIds,
        _votingEvents = votingEvents;

  factory _$_Rooms.fromJson(Map<String, dynamic> json) =>
      _$$_RoomsFromJson(json);

  @override
  @JsonKey()
  final String roomId;
  @override
  @JsonKey()
  final String roomName;
  @override
  @JsonKey()
  @unionTimestampConverter
  final UnionTimestamp createdAt;
  final List<String> _userIds;
  @override
  @JsonKey()
  List<String> get userIds {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_userIds);
  }

  final List<VotingEvent> _votingEvents;
  @override
  @JsonKey()
  List<VotingEvent> get votingEvents {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_votingEvents);
  }

  @override
  String toString() {
    return 'Room(roomId: $roomId, roomName: $roomName, createdAt: $createdAt, userIds: $userIds, votingEvents: $votingEvents)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Rooms &&
            const DeepCollectionEquality().equals(other.roomId, roomId) &&
            const DeepCollectionEquality().equals(other.roomName, roomName) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt) &&
            const DeepCollectionEquality().equals(other._userIds, _userIds) &&
            const DeepCollectionEquality()
                .equals(other._votingEvents, _votingEvents));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(roomId),
      const DeepCollectionEquality().hash(roomName),
      const DeepCollectionEquality().hash(createdAt),
      const DeepCollectionEquality().hash(_userIds),
      const DeepCollectionEquality().hash(_votingEvents));

  @JsonKey(ignore: true)
  @override
  _$$_RoomsCopyWith<_$_Rooms> get copyWith =>
      __$$_RoomsCopyWithImpl<_$_Rooms>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RoomsToJson(
      this,
    );
  }
}

abstract class _Rooms implements Room {
  const factory _Rooms(
      {final String roomId,
      final String roomName,
      @unionTimestampConverter final UnionTimestamp createdAt,
      final List<String> userIds,
      final List<VotingEvent> votingEvents}) = _$_Rooms;

  factory _Rooms.fromJson(Map<String, dynamic> json) = _$_Rooms.fromJson;

  @override
  String get roomId;
  @override
  String get roomName;
  @override
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  List<String> get userIds;
  @override
  List<VotingEvent> get votingEvents;
  @override
  @JsonKey(ignore: true)
  _$$_RoomsCopyWith<_$_Rooms> get copyWith =>
      throw _privateConstructorUsedError;
}
