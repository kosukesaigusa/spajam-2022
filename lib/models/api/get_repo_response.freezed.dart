// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'get_repo_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GetRepoResponse _$GetRepoResponseFromJson(Map<String, dynamic> json) {
  return _GetRepoResponse.fromJson(json);
}

/// @nodoc
mixin _$GetRepoResponse {
  bool get success => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Repo get repo => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GetRepoResponseCopyWith<GetRepoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GetRepoResponseCopyWith<$Res> {
  factory $GetRepoResponseCopyWith(
          GetRepoResponse value, $Res Function(GetRepoResponse) then) =
      _$GetRepoResponseCopyWithImpl<$Res>;
  $Res call({bool success, String message, Repo repo});

  $RepoCopyWith<$Res> get repo;
}

/// @nodoc
class _$GetRepoResponseCopyWithImpl<$Res>
    implements $GetRepoResponseCopyWith<$Res> {
  _$GetRepoResponseCopyWithImpl(this._value, this._then);

  final GetRepoResponse _value;
  // ignore: unused_field
  final $Res Function(GetRepoResponse) _then;

  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? repo = freezed,
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
      repo: repo == freezed
          ? _value.repo
          : repo // ignore: cast_nullable_to_non_nullable
              as Repo,
    ));
  }

  @override
  $RepoCopyWith<$Res> get repo {
    return $RepoCopyWith<$Res>(_value.repo, (value) {
      return _then(_value.copyWith(repo: value));
    });
  }
}

/// @nodoc
abstract class _$$_GetRepoResponseCopyWith<$Res>
    implements $GetRepoResponseCopyWith<$Res> {
  factory _$$_GetRepoResponseCopyWith(
          _$_GetRepoResponse value, $Res Function(_$_GetRepoResponse) then) =
      __$$_GetRepoResponseCopyWithImpl<$Res>;
  @override
  $Res call({bool success, String message, Repo repo});

  @override
  $RepoCopyWith<$Res> get repo;
}

/// @nodoc
class __$$_GetRepoResponseCopyWithImpl<$Res>
    extends _$GetRepoResponseCopyWithImpl<$Res>
    implements _$$_GetRepoResponseCopyWith<$Res> {
  __$$_GetRepoResponseCopyWithImpl(
      _$_GetRepoResponse _value, $Res Function(_$_GetRepoResponse) _then)
      : super(_value, (v) => _then(v as _$_GetRepoResponse));

  @override
  _$_GetRepoResponse get _value => super._value as _$_GetRepoResponse;

  @override
  $Res call({
    Object? success = freezed,
    Object? message = freezed,
    Object? repo = freezed,
  }) {
    return _then(_$_GetRepoResponse(
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
      message: message == freezed
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      repo: repo == freezed
          ? _value.repo
          : repo // ignore: cast_nullable_to_non_nullable
              as Repo,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$_GetRepoResponse implements _GetRepoResponse {
  const _$_GetRepoResponse(
      {this.success = true, this.message = '', this.repo = Repo.defaultValue});

  factory _$_GetRepoResponse.fromJson(Map<String, dynamic> json) =>
      _$$_GetRepoResponseFromJson(json);

  @override
  @JsonKey()
  final bool success;
  @override
  @JsonKey()
  final String message;
  @override
  @JsonKey()
  final Repo repo;

  @override
  String toString() {
    return 'GetRepoResponse(success: $success, message: $message, repo: $repo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GetRepoResponse &&
            const DeepCollectionEquality().equals(other.success, success) &&
            const DeepCollectionEquality().equals(other.message, message) &&
            const DeepCollectionEquality().equals(other.repo, repo));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(success),
      const DeepCollectionEquality().hash(message),
      const DeepCollectionEquality().hash(repo));

  @JsonKey(ignore: true)
  @override
  _$$_GetRepoResponseCopyWith<_$_GetRepoResponse> get copyWith =>
      __$$_GetRepoResponseCopyWithImpl<_$_GetRepoResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GetRepoResponseToJson(
      this,
    );
  }
}

abstract class _GetRepoResponse implements GetRepoResponse {
  const factory _GetRepoResponse(
      {final bool success,
      final String message,
      final Repo repo}) = _$_GetRepoResponse;

  factory _GetRepoResponse.fromJson(Map<String, dynamic> json) =
      _$_GetRepoResponse.fromJson;

  @override
  bool get success;
  @override
  String get message;
  @override
  Repo get repo;
  @override
  @JsonKey(ignore: true)
  _$$_GetRepoResponseCopyWith<_$_GetRepoResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
