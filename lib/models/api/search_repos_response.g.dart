// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'search_repos_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchReposResponse _$$_SearchReposResponseFromJson(Map json) =>
    $checkedCreate(
      r'_$_SearchReposResponse',
      json,
      ($checkedConvert) {
        final val = _$_SearchReposResponse(
          success: $checkedConvert('success', (v) => v as bool? ?? true),
          message: $checkedConvert('message', (v) => v as String? ?? ''),
          totalCount: $checkedConvert('totalCount', (v) => v as int? ?? 0),
          incompleteResults:
              $checkedConvert('incompleteResults', (v) => v as bool? ?? false),
          repos: $checkedConvert(
              'items',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          Repo.fromJson(Map<String, dynamic>.from(e as Map)))
                      .toList() ??
                  const <Repo>[]),
        );
        return val;
      },
      fieldKeyMap: const {'repos': 'items'},
    );

Map<String, dynamic> _$$_SearchReposResponseToJson(
        _$_SearchReposResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'totalCount': instance.totalCount,
      'incompleteResults': instance.incompleteResults,
      'items': instance.repos.map((e) => e.toJson()).toList(),
    };
