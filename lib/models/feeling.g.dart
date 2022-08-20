// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'feeling.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Feeling _$$_FeelingFromJson(Map json) => $checkedCreate(
      r'_$_Feeling',
      json,
      ($checkedConvert) {
        final val = _$_Feeling(
          userId: $checkedConvert('userId', (v) => v as String? ?? ''),
          isComfortable:
              $checkedConvert('isComfortable', (v) => v as bool? ?? true),
          createdAt: $checkedConvert(
              'createdAt',
              (v) => v == null
                  ? const UnionTimestamp.serverTimestamp()
                  : unionTimestampConverter.fromJson(v as Object)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_FeelingToJson(_$_Feeling instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isComfortable': instance.isComfortable,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
    };
