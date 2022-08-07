// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'get_repo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GetRepoResponse _$$_GetRepoResponseFromJson(Map json) => $checkedCreate(
      r'_$_GetRepoResponse',
      json,
      ($checkedConvert) {
        final val = _$_GetRepoResponse(
          success: $checkedConvert('success', (v) => v as bool? ?? true),
          message: $checkedConvert('message', (v) => v as String? ?? ''),
          repo: $checkedConvert(
              'repo',
              (v) => v == null
                  ? Repo.defaultValue
                  : Repo.fromJson(Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_GetRepoResponseToJson(_$_GetRepoResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'repo': instance.repo.toJson(),
    };
