// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return _Todo.fromJson(json);
}

/// @nodoc
mixin _$Todo {
  String get todoId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @timestampConverter
  DateTime? get dueDateTime => throw _privateConstructorUsedError;
  bool get isDone => throw _privateConstructorUsedError;
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoCopyWith<Todo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) =
      _$TodoCopyWithImpl<$Res>;
  $Res call(
      {String todoId,
      String userId,
      String title,
      String description,
      @timestampConverter
          DateTime? dueDateTime,
      bool isDone,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp updatedAt});

  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class _$TodoCopyWithImpl<$Res> implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  final Todo _value;
  // ignore: unused_field
  final $Res Function(Todo) _then;

  @override
  $Res call({
    Object? todoId = freezed,
    Object? userId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dueDateTime = freezed,
    Object? isDone = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dueDateTime: dueDateTime == freezed
          ? _value.dueDateTime
          : dueDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }

  @override
  $UnionTimestampCopyWith<$Res> get updatedAt {
    return $UnionTimestampCopyWith<$Res>(_value.updatedAt, (value) {
      return _then(_value.copyWith(updatedAt: value));
    });
  }
}

/// @nodoc
abstract class _$$_TodoCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$$_TodoCopyWith(_$_Todo value, $Res Function(_$_Todo) then) =
      __$$_TodoCopyWithImpl<$Res>;
  @override
  $Res call(
      {String todoId,
      String userId,
      String title,
      String description,
      @timestampConverter
          DateTime? dueDateTime,
      bool isDone,
      @alwaysUseServerTimestampUnionTimestampConverter
          UnionTimestamp updatedAt});

  @override
  $UnionTimestampCopyWith<$Res> get updatedAt;
}

/// @nodoc
class __$$_TodoCopyWithImpl<$Res> extends _$TodoCopyWithImpl<$Res>
    implements _$$_TodoCopyWith<$Res> {
  __$$_TodoCopyWithImpl(_$_Todo _value, $Res Function(_$_Todo) _then)
      : super(_value, (v) => _then(v as _$_Todo));

  @override
  _$_Todo get _value => super._value as _$_Todo;

  @override
  $Res call({
    Object? todoId = freezed,
    Object? userId = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? dueDateTime = freezed,
    Object? isDone = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$_Todo(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: userId == freezed
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      dueDateTime: dueDateTime == freezed
          ? _value.dueDateTime
          : dueDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      updatedAt: updatedAt == freezed
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as UnionTimestamp,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Todo extends _Todo {
  const _$_Todo(
      {this.todoId = '',
      this.userId = '',
      this.title = '',
      this.description = '',
      @timestampConverter
          this.dueDateTime,
      this.isDone = false,
      @alwaysUseServerTimestampUnionTimestampConverter
          this.updatedAt = const UnionTimestamp.serverTimestamp()})
      : super._();

  factory _$_Todo.fromJson(Map<String, dynamic> json) => _$$_TodoFromJson(json);

  @override
  @JsonKey()
  final String todoId;
  @override
  @JsonKey()
  final String userId;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @timestampConverter
  final DateTime? dueDateTime;
  @override
  @JsonKey()
  final bool isDone;
  @override
  @JsonKey()
  @alwaysUseServerTimestampUnionTimestampConverter
  final UnionTimestamp updatedAt;

  @override
  String toString() {
    return 'Todo(todoId: $todoId, userId: $userId, title: $title, description: $description, dueDateTime: $dueDateTime, isDone: $isDone, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Todo &&
            const DeepCollectionEquality().equals(other.todoId, todoId) &&
            const DeepCollectionEquality().equals(other.userId, userId) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.dueDateTime, dueDateTime) &&
            const DeepCollectionEquality().equals(other.isDone, isDone) &&
            const DeepCollectionEquality().equals(other.updatedAt, updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(todoId),
      const DeepCollectionEquality().hash(userId),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(dueDateTime),
      const DeepCollectionEquality().hash(isDone),
      const DeepCollectionEquality().hash(updatedAt));

  @JsonKey(ignore: true)
  @override
  _$$_TodoCopyWith<_$_Todo> get copyWith =>
      __$$_TodoCopyWithImpl<_$_Todo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoToJson(
      this,
    );
  }
}

abstract class _Todo extends Todo {
  const factory _Todo(
      {final String todoId,
      final String userId,
      final String title,
      final String description,
      @timestampConverter
          final DateTime? dueDateTime,
      final bool isDone,
      @alwaysUseServerTimestampUnionTimestampConverter
          final UnionTimestamp updatedAt}) = _$_Todo;
  const _Todo._() : super._();

  factory _Todo.fromJson(Map<String, dynamic> json) = _$_Todo.fromJson;

  @override
  String get todoId;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get description;
  @override
  @timestampConverter
  DateTime? get dueDateTime;
  @override
  bool get isDone;
  @override
  @alwaysUseServerTimestampUnionTimestampConverter
  UnionTimestamp get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_TodoCopyWith<_$_Todo> get copyWith => throw _privateConstructorUsedError;
}
