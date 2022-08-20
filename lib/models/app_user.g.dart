// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'app_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AppUser _$$_AppUserFromJson(Map json) => $checkedCreate(
      r'_$_AppUser',
      json,
      ($checkedConvert) {
        final val = _$_AppUser(
          userId: $checkedConvert('userId', (v) => v as String? ?? ''),
          fcmTokens: $checkedConvert(
              'fcmTokens',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const <String>[]),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_AppUserToJson(_$_AppUser instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'fcmTokens': instance.fcmTokens,
    };
