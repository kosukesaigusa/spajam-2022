// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'feeling.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Feeling _$FeelingFromJson(Map<String, dynamic> json) {
  return _Feeling.fromJson(json);
}

/// @nodoc
mixin _$Feeling {
  String get feelingId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  bool get isComfortable => throw _privateConstructorUsedError;
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeelingCopyWith<Feeling> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeelingCopyWith<$Res> {
  factory $FeelingCopyWith(Feeling value, $Res Function(Feeling) then) =
      _$FeelingCopyWithImpl<$Res>;
  $Res call(
      {String feelingId,
      String userId,
      bool isComfortable,
      @unionTimestampConverter UnionTimestamp createdAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$FeelingCopyWithImpl<$Res> implements $FeelingCopyWith<$Res> {
  _$FeelingCopyWithImpl(this._value, this._then);

  final Feeling _value;
  // ignore: unused_field
  final $Res Function(Feeling) _then;

  @override
  $Res call({
    Object? feelingId = freezed,
    Object? userId = freezed,
    Object? isComfortable = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      feelingId: feelingId == freezed
          ? _value.feelingId
          : feelingId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isComfortable: isComfortable == freezed
          ? _value.isComfortable
          : isComfortable // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$_FeelingCopyWith<$Res> implements $FeelingCopyWith<$Res> {
  factory _$$_FeelingCopyWith(
          _$_Feeling value, $Res Function(_$_Feeling) then) =
      __$$_FeelingCopyWithImpl<$Res>;
  @override
  $Res call(
      {String feelingId,
      String userId,
      bool isComfortable,
      @unionTimestampConverter UnionTimestamp createdAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$_FeelingCopyWithImpl<$Res> extends _$FeelingCopyWithImpl<$Res>
    implements _$$_FeelingCopyWith<$Res> {
  __$$_FeelingCopyWithImpl(_$_Feeling _value, $Res Function(_$_Feeling) _then)
      : super(_value, (v) => _then(v as _$_Feeling));

  @override
  _$_Feeling get _value => super._value as _$_Feeling;

  @override
  $Res call({
    Object? feelingId = freezed,
    Object? userId = freezed,
    Object? isComfortable = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_Feeling(
      feelingId: feelingId == freezed
          ? _value.feelingId
          : feelingId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      isComfortable: isComfortable == freezed
          ? _value.isComfortable
          : isComfortable // ignore: cast_nullable_to_non_nullable
              as bool,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Feeling implements _Feeling {
  const _$_Feeling(
      {this.feelingId = '',
      this.userId = '',
      this.isComfortable = true,
      @unionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp()});

  factory _$_Feeling.fromJson(Map<String, dynamic> json) =>
      _$$_FeelingFromJson(json);

  @override
  @JsonKey()
  final String feelingId;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final bool isComfortable;
  @override
  @JsonKey()
  @unionTimestampConverter
  final UnionTimestamp createdAt;

  @override
  String toString() {
    return 'Feeling(feelingId: $feelingId, userId: $userId, isComfortable: $isComfortable, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Feeling &&
            const DeepCollectionEquality().equals(other.feelingId, feelingId) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality()
                .equals(other.isComfortable, isComfortable) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(feelingId),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(isComfortable),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_FeelingCopyWith<_$_Feeling> get copyWith =>
      __$$_FeelingCopyWithImpl<_$_Feeling>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FeelingToJson(
      this,
    );
  }
}

abstract class _Feeling implements Feeling {
  const factory _Feeling(
      {final String feelingId,
      final String userId,
      final bool isComfortable,
      @unionTimestampConverter final UnionTimestamp createdAt}) = _$_Feeling;

  factory _Feeling.fromJson(Map<String, dynamic> json) = _$_Feeling.fromJson;

  @override
  String get feelingId;
  @override
  String get userId;
  @override
  bool get isComfortable;
  @override
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_FeelingCopyWith<_$_Feeling> get copyWith =>
      throw _privateConstructorUsedError;
}
