// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'base_response_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BaseResponseData _$$_BaseResponseDataFromJson(Map json) => $checkedCreate(
      r'_$_BaseResponseData',
      json,
      ($checkedConvert) {
        final val = _$_BaseResponseData(
          success: $checkedConvert('success', (v) => v as bool? ?? true),
          message: $checkedConvert('message', (v) => v as String? ?? ''),
          data: $checkedConvert(
              'data',
              (v) =>
                  v == null ? emptyMap : baseResponseDataConverter.fromJson(v)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_BaseResponseDataToJson(_$_BaseResponseData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': baseResponseDataConverter.toJson(instance.data),
    };
