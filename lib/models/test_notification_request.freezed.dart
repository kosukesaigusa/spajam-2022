// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'test_notification_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TestNotificationRequest _$TestNotificationRequestFromJson(
    Map<String, dynamic> json) {
  return _TestNotificationRequest.fromJson(json);
}

/// @nodoc
mixin _$TestNotificationRequest {
  String get token => throw _privateConstructorUsedError;
  String get testNotificationRequest => throw _privateConstructorUsedError;
  TestNotificationRequestType get testNotificationRequestType =>
      throw _privateConstructorUsedError;
  @unionTimestampConverter
  UnionTimestamp get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TestNotificationRequestCopyWith<TestNotificationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TestNotificationRequestCopyWith<$Res> {
  factory $TestNotificationRequestCopyWith(TestNotificationRequest value,
          $Res Function(TestNotificationRequest) then) =
      _$TestNotificationRequestCopyWithImpl<$Res>;
  $Res call(
      {String token,
      String testNotificationRequest,
      TestNotificationRequestType testNotificationRequestType,
      @unionTimestampConverter UnionTimestamp createdAt});

  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class _$TestNotificationRequestCopyWithImpl<$Res>
    implements $TestNotificationRequestCopyWith<$Res> {
  _$TestNotificationRequestCopyWithImpl(this._value, this._then);

  final TestNotificationRequest _value;
  // ignore: unused_field
  final $Res Function(TestNotificationRequest) _then;

  @override
  $Res call({
    Object? token = freezed,
    Object? testNotificationRequest = freezed,
    Object? testNotificationRequestType = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      testNotificationRequest: testNotificationRequest == freezed
          ? _value.testNotificationRequest
          : testNotificationRequest // ignore: cast_nullable_to_non_nullable
              as String,
      testNotificationRequestType: testNotificationRequestType == freezed
          ? _value.testNotificationRequestType
          : testNotificationRequestType // ignore: cast_nullable_to_non_nullable
              as TestNotificationRequestType,
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
abstract class _$$_TestNotificationRequestCopyWith<$Res>
    implements $TestNotificationRequestCopyWith<$Res> {
  factory _$$_TestNotificationRequestCopyWith(_$_TestNotificationRequest value,
          $Res Function(_$_TestNotificationRequest) then) =
      __$$_TestNotificationRequestCopyWithImpl<$Res>;
  @override
  $Res call(
      {String token,
      String testNotificationRequest,
      TestNotificationRequestType testNotificationRequestType,
      @unionTimestampConverter UnionTimestamp createdAt});

  @override
  $UnionTimestampCopyWith<$Res> get createdAt;
}

/// @nodoc
class __$$_TestNotificationRequestCopyWithImpl<$Res>
    extends _$TestNotificationRequestCopyWithImpl<$Res>
    implements _$$_TestNotificationRequestCopyWith<$Res> {
  __$$_TestNotificationRequestCopyWithImpl(_$_TestNotificationRequest _value,
      $Res Function(_$_TestNotificationRequest) _then)
      : super(_value, (v) => _then(v as _$_TestNotificationRequest));

  @override
  _$_TestNotificationRequest get _value =>
      super._value as _$_TestNotificationRequest;

  @override
  $Res call({
    Object? token = freezed,
    Object? testNotificationRequest = freezed,
    Object? testNotificationRequestType = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$_TestNotificationRequest(
      token: token == freezed
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      testNotificationRequest: testNotificationRequest == freezed
          ? _value.testNotificationRequest
          : testNotificationRequest // ignore: cast_nullable_to_non_nullable
              as String,
      testNotificationRequestType: testNotificationRequestType == freezed
          ? _value.testNotificationRequestType
          : testNotificationRequestType // ignore: cast_nullable_to_non_nullable
              as TestNotificationRequestType,
      createdAt: createdAt == freezed
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TestNotificationRequest extends _TestNotificationRequest {
  const _$_TestNotificationRequest(
      {this.token = '',
      this.testNotificationRequest = '',
      this.testNotificationRequestType = TestNotificationRequestType.normal,
      @unionTimestampConverter
          this.createdAt = const UnionTimestamp.serverTimestamp()})
      : super._();

  factory _$_TestNotificationRequest.fromJson(Map<String, dynamic> json) =>
      _$$_TestNotificationRequestFromJson(json);

  @override
  @JsonKey()
  final String token;
  @override
  @JsonKey()
  final String testNotificationRequest;
  @override
  @JsonKey()
  final TestNotificationRequestType testNotificationRequestType;
  @override
  @JsonKey()
  @unionTimestampConverter
  final UnionTimestamp createdAt;

  @override
  String toString() {
    return 'TestNotificationRequest(token: $token, testNotificationRequest: $testNotificationRequest, testNotificationRequestType: $testNotificationRequestType, createdAt: $createdAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TestNotificationRequest &&
            const DeepCollectionEquality().equals(other.token, token) &&
            const DeepCollectionEquality().equals(
                other.testNotificationRequest, testNotificationRequest) &&
            const DeepCollectionEquality().equals(
                other.testNotificationRequestType,
                testNotificationRequestType) &&
            const DeepCollectionEquality().equals(other.createdAt, createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(token),
      const DeepCollectionEquality().hash(testNotificationRequest),
      const DeepCollectionEquality().hash(testNotificationRequestType),
      const DeepCollectionEquality().hash(createdAt));

  @JsonKey(ignore: true)
  @override
  _$$_TestNotificationRequestCopyWith<_$_TestNotificationRequest>
      get copyWith =>
          __$$_TestNotificationRequestCopyWithImpl<_$_TestNotificationRequest>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TestNotificationRequestToJson(
      this,
    );
  }
}

abstract class _TestNotificationRequest extends TestNotificationRequest {
  const factory _TestNotificationRequest(
          {final String token,
          final String testNotificationRequest,
          final TestNotificationRequestType testNotificationRequestType,
          @unionTimestampConverter final UnionTimestamp createdAt}) =
      _$_TestNotificationRequest;
  const _TestNotificationRequest._() : super._();

  factory _TestNotificationRequest.fromJson(Map<String, dynamic> json) =
      _$_TestNotificationRequest.fromJson;

  @override
  String get token;
  @override
  String get testNotificationRequest;
  @override
  TestNotificationRequestType get testNotificationRequestType;
  @override
  @unionTimestampConverter
  UnionTimestamp get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$_TestNotificationRequestCopyWith<_$_TestNotificationRequest>
      get copyWith => throw _privateConstructorUsedError;
}
