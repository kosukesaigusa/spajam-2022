// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'test_notification_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TestNotificationRequest _$$_TestNotificationRequestFromJson(Map json) =>
    $checkedCreate(
      r'_$_TestNotificationRequest',
      json,
      ($checkedConvert) {
        final val = _$_TestNotificationRequest(
          token: $checkedConvert('token', (v) => v as String? ?? ''),
          testNotificationRequest: $checkedConvert(
              'testNotificationRequest', (v) => v as String? ?? ''),
          testNotificationRequestType: $checkedConvert(
              'testNotificationRequestType',
              (v) =>
                  $enumDecodeNullable(
                      _$TestNotificationRequestTypeEnumMap, v) ??
                  TestNotificationRequestType.normal),
          createdAt: $checkedConvert(
              'createdAt',
              (v) => v == null
                  ? const UnionTimestamp.serverTimestamp()
                  : unionTimestampConverter.fromJson(v as Object)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_TestNotificationRequestToJson(
        _$_TestNotificationRequest instance) =>
    <String, dynamic>{
      'token': instance.token,
      'testNotificationRequest': instance.testNotificationRequest,
      'testNotificationRequestType': _$TestNotificationRequestTypeEnumMap[
          instance.testNotificationRequestType]!,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
    };

const _$TestNotificationRequestTypeEnumMap = {
  TestNotificationRequestType.normal: 'normal',
  TestNotificationRequestType.github: 'github',
};
