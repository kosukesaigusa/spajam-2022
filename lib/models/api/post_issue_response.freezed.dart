// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'post_issue_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostIssueResponse _$PostIssueResponseFromJson(Map<String, dynamic> json) {
  return _PostIssueResponse.fromJson(json);
}

/// @nodoc
mixin _$PostIssueResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Issue get issue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostIssueResponseCopyWith<PostIssueResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostIssueResponseCopyWith<$Res> {
  factory $PostIssueResponseCopyWith(
          PostIssueResponse value, $Res Function(PostIssueResponse) then) =
      _$PostIssueResponseCopyWithImpl<$Res>;
  $Res call({bool success, String message, Issue issue});

  $IssueCopyWith<$Res> get issue;
}

/// @nodoc
class _$PostIssueResponseCopyWithImpl<$Res>
    implements $PostIssueResponseCopyWith<$Res> {
  _$PostIssueResponseCopyWithImpl(this._value, this._then);

  final PostIssueResponse _value;
  // ignore: unused_field
  final $Res Function(PostIssueResponse) _then;

  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? issue = freezed,
  }) {
    return _then(_value.copyWith(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      issue: issue == freezed
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as Issue,
    ));
  }

  @override
  $IssueCopyWith<$Res> get issue {
    return $IssueCopyWith<$Res>(_value.issue, (value) {
      return _then(_value.copyWith(issue: value));
    });
  }
}

/// @nodoc
abstract class _$$_PostIssueResponseCopyWith<$Res>
    implements $PostIssueResponseCopyWith<$Res> {
  factory _$$_PostIssueResponseCopyWith(_$_PostIssueResponse value,
          $Res Function(_$_PostIssueResponse) then) =
      __$$_PostIssueResponseCopyWithImpl<$Res>;
  @override
  $Res call({bool success, String message, Issue issue});

  @override
  $IssueCopyWith<$Res> get issue;
}

/// @nodoc
class __$$_PostIssueResponseCopyWithImpl<$Res>
    extends _$PostIssueResponseCopyWithImpl<$Res>
    implements _$$_PostIssueResponseCopyWith<$Res> {
  __$$_PostIssueResponseCopyWithImpl(
      _$_PostIssueResponse _value, $Res Function(_$_PostIssueResponse) _then)
      : super(_value, (v) => _then(v as _$_PostIssueResponse));

  @override
  _$_PostIssueResponse get _value => super._value as _$_PostIssueResponse;

  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? issue = freezed,
  }) {
    return _then(_$_PostIssueResponse(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      issue: issue == freezed
          ? _value.issue
          : issue // ignore: cast_nullable_to_non_nullable
              as Issue,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostIssueResponse implements _PostIssueResponse {
  const _$_PostIssueResponse(
      {this.success = true,
      this.message = '',
      this.issue = Issue.defaultValue});

  factory _$_PostIssueResponse.fromJson(Map<String, dynamic> json) =>
      _$$_PostIssueResponseFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final Issue issue;

  @override
  String toString() {
    return 'PostIssueResponse(success: $success, message: $message, issue: $issue)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostIssueResponse &&
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.issue, issue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(issue));

  @JsonKey(ignore: true)
  @override
  _$$_PostIssueResponseCopyWith<_$_PostIssueResponse> get copyWith =>
      __$$_PostIssueResponseCopyWithImpl<_$_PostIssueResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostIssueResponseToJson(
      this,
    );
  }
}

abstract class _PostIssueResponse implements PostIssueResponse {
  const factory _PostIssueResponse(
      {final bool success,
      final String message,
      final Issue issue}) = _$_PostIssueResponse;

  factory _PostIssueResponse.fromJson(Map<String, dynamic> json) =
      _$_PostIssueResponse.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  Issue get issue;
  @override
  @JsonKey(ignore: true)
  _$$_PostIssueResponseCopyWith<_$_PostIssueResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
