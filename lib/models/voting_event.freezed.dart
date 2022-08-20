// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'voting_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VotingEvent _$VotingEventFromJson(Map<String, dynamic> json) {
  return _VotingEvent.fromJson(json);
}

/// @nodoc
mixin _$VotingEvent {
  String get votingEventId => throw _privateConstructorUsedError;
  List<String> get votingUserIds => throw _privateConstructorUsedError;
  VotingEventStatus get status => throw _privateConstructorUsedError;
  VoteEnum get result => throw _privateConstructorUsedError;
  List<Feeling> get feelings => throw _privateConstructorUsedError;
  List<Vote> get votes => throw _privateConstructorUsedError;
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VotingEventCopyWith<VotingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VotingEventCopyWith<$Res> {
  factory $VotingEventCopyWith(
          VotingEvent value, $Res Function(VotingEvent) then) =
      _$VotingEventCopyWithImpl<$Res>;
  $Res call(
      {String votingEventId,
      List<String> votingUserIds,
      VotingEventStatus status,
      VoteEnum result,
      List<Feeling> feelings,
      List<Vote> votes,
      @unionTimestampConverter UnionTimestamp createdAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$VotingEventCopyWithImpl<$Res> implements $VotingEventCopyWith<$Res> {
  _$VotingEventCopyWithImpl(this._value, this._then);

  final VotingEvent _value;
  // ignore: unused_field
  final $Res Function(VotingEvent) _then;

  @override
  $Res call({
    Object? votingEventId = freezed,
    Object? votingUserIds = freezed,
    Object? status = freezed,
    Object? result = freezed,
    Object? feelings = freezed,
    Object? votes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      votingEventId: votingEventId == freezed
          ? _value.votingEventId
          : votingEventId // ignore: cast_nullable_to_non_nullable
              as String,
      votingUserIds: votingUserIds == freezed
          ? _value.votingUserIds
          : votingUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VotingEventStatus,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as VoteEnum,
      feelings: feelings == freezed
          ? _value.feelings
          : feelings // ignore: cast_nullable_to_non_nullable
              as List<Feeling>,
      votes: votes == freezed
          ? _value.votes
          : votes // ignore: cast_nullable_to_non_nullable
              as List<Vote>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
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
abstract class _$$_VotingEventCopyWith<$Res>
    implements $VotingEventCopyWith<$Res> {
  factory _$$_VotingEventCopyWith(
          _$_VotingEvent value, $Res Function(_$_VotingEvent) then) =
      __$$_VotingEventCopyWithImpl<$Res>;
  @override
  $Res call(
      {String votingEventId,
      List<String> votingUserIds,
      VotingEventStatus status,
      VoteEnum result,
      List<Feeling> feelings,
      List<Vote> votes,
      @unionTimestampConverter UnionTimestamp createdAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$_VotingEventCopyWithImpl<$Res> extends _$VotingEventCopyWithImpl<$Res>
    implements _$$_VotingEventCopyWith<$Res> {
  __$$_VotingEventCopyWithImpl(
      _$_VotingEvent _value, $Res Function(_$_VotingEvent) _then)
      : super(_value, (v) => _then(v as _$_VotingEvent));

  @override
  _$_VotingEvent get _value => super._value as _$_VotingEvent;

  @override
  $Res call({
    Object? votingEventId = freezed,
    Object? votingUserIds = freezed,
    Object? status = freezed,
    Object? result = freezed,
    Object? feelings = freezed,
    Object? votes = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_VotingEvent(
      votingEventId: votingEventId == freezed
          ? _value.votingEventId
          : votingEventId // ignore: cast_nullable_to_non_nullable
              as String,
      votingUserIds: votingUserIds == freezed
          ? _value._votingUserIds
          : votingUserIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as VotingEventStatus,
      result: result == freezed
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as VoteEnum,
      feelings: feelings == freezed
          ? _value._feelings
          : feelings // ignore: cast_nullable_to_non_nullable
              as List<Feeling>,
      votes: votes == freezed
          ? _value._votes
          : votes // ignore: cast_nullable_to_non_nullable
              as List<Vote>,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_VotingEvent implements _VotingEvent {
  _$_VotingEvent(
      {this.votingEventId = '',
      final List<String> votingUserIds = const <String>[],
      this.status = VotingEventStatus.peace,
      this.result = VoteEnum.comfortable,
      final List<Feeling> feelings = const <Feeling>[],
      final List<Vote> votes = const <Vote>[],
      @unionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp()})
      : _votingUserIds = votingUserIds,
        _feelings = feelings,
        _votes = votes;

  factory _$_VotingEvent.fromJson(Map<String, dynamic> json) =>
      _$$_VotingEventFromJson(json);

  @override
  @JsonKey()
  final String votingEventId;
  final List<String> _votingUserIds;
  @override
  @JsonKey()
  List<String> get votingUserIds {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_votingUserIds);
  }

  @override
  @JsonKey()
  final VotingEventStatus status;
  @override
  @JsonKey()
  final VoteEnum result;
  final List<Feeling> _feelings;
  @override
  @JsonKey()
  List<Feeling> get feelings {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_feelings);
  }

  final List<Vote> _votes;
  @override
  @JsonKey()
  List<Vote> get votes {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_votes);
  }

  @override
  @JsonKey()
  @unionTimestampConverter
  final UnionTimestamp createdAt;

  @override
  String toString() {
    return 'VotingEvent(votingEventId: $votingEventId, votingUserIds: $votingUserIds, status: $status, result: $result, feelings: $feelings, votes: $votes, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VotingEvent &&
            const DeepCollectionEquality()
                .equals(other.votingEventId, votingEventId) &&
            const DeepCollectionEquality()
                .equals(other._votingUserIds, _votingUserIds) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality().equals(other.result, result) &&
            const DeepCollectionEquality().equals(other._feelings, _feelings) &&
            const DeepCollectionEquality().equals(other._votes, _votes) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(votingEventId),
      const DeepCollectionEquality().hash(_votingUserIds),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(result),
      const DeepCollectionEquality().hash(_feelings),
      const DeepCollectionEquality().hash(_votes),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_VotingEventCopyWith<_$_VotingEvent> get copyWith =>
      __$$_VotingEventCopyWithImpl<_$_VotingEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VotingEventToJson(
      this,
    );
  }
}

abstract class _VotingEvent implements VotingEvent {
  factory _VotingEvent(
          {final String votingEventId,
          final List<String> votingUserIds,
          final VotingEventStatus status,
          final VoteEnum result,
          final List<Feeling> feelings,
          final List<Vote> votes,
          @unionTimestampConverter final UnionTimestamp createdAt}) =
      _$_VotingEvent;

  factory _VotingEvent.fromJson(Map<String, dynamic> json) =
      _$_VotingEvent.fromJson;

  @override
  String get votingEventId;
  @override
  List<String> get votingUserIds;
  @override
  VotingEventStatus get status;
  @override
  VoteEnum get result;
  @override
  List<Feeling> get feelings;
  @override
  List<Vote> get votes;
  @override
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_VotingEventCopyWith<_$_VotingEvent> get copyWith =>
      throw _privateConstructorUsedError;
}
