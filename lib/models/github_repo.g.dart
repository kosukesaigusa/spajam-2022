// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'github_repo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Repo _$$_RepoFromJson(Map json) => $checkedCreate(
      r'_$_Repo',
      json,
      ($checkedConvert) {
        final val = _$_Repo(
          id: $checkedConvert('id', (v) => v as int? ?? 0),
          name: $checkedConvert('name', (v) => v as String? ?? ''),
          owner: $checkedConvert(
              'owner',
              (v) => v == null
                  ? Owner.defaultValue
                  : Owner.fromJson(Map<String, dynamic>.from(v as Map))),
          htmlUrl: $checkedConvert('htmlUrl', (v) => v as String? ?? ''),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          updatedAt: $checkedConvert('updatedAt',
              (v) => v == null ? null : DateTime.parse(v as String)),
          stargazersCount:
              $checkedConvert('stargazersCount', (v) => v as int? ?? 0),
          forksCount: $checkedConvert('forksCount', (v) => v as int? ?? 0),
          watchersCount:
              $checkedConvert('watchersCount', (v) => v as int? ?? 0),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_RepoToJson(_$_Repo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner.toJson(),
      'htmlUrl': instance.htmlUrl,
      'description': instance.description,
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'stargazersCount': instance.stargazersCount,
      'forksCount': instance.forksCount,
      'watchersCount': instance.watchersCount,
    };
