// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map json) => $checkedCreate(
      r'_$_Todo',
      json,
      ($checkedConvert) {
        final val = _$_Todo(
          todoId: $checkedConvert('todoId', (v) => v as String? ?? ''),
          userId: $checkedConvert('userId', (v) => v as String? ?? ''),
          title: $checkedConvert('title', (v) => v as String? ?? ''),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          dueDateTime: $checkedConvert(
              'dueDateTime', (v) => timestampConverter.fromJson(v)),
          isDone: $checkedConvert('isDone', (v) => v as bool? ?? false),
          updatedAt: $checkedConvert(
              'updatedAt',
              (v) => v == null
                  ? const UnionTimestamp.serverTimestamp()
                  : alwaysUseServerTimestampUnionTimestampConverter
                      .fromJson(v as Object)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'todoId': instance.todoId,
      'userId': instance.userId,
      'title': instance.title,
      'description': instance.description,
      'dueDateTime': timestampConverter.toJson(instance.dueDateTime),
      'isDone': instance.isDone,
      'updatedAt': alwaysUseServerTimestampUnionTimestampConverter
          .toJson(instance.updatedAt),
    };
