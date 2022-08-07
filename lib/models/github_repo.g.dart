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
          htmlUrl: $checkedConvert('html_url', (v) => v as String? ?? ''),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          updatedAt: $checkedConvert('updated_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          stargazersCount:
              $checkedConvert('stargazers_count', (v) => v as int? ?? 0),
          forksCount: $checkedConvert('forks_count', (v) => v as int? ?? 0),
          watchersCount:
              $checkedConvert('watchers_count', (v) => v as int? ?? 0),
        );
        return val;
      },
      fieldKeyMap: const {
        'htmlUrl': 'html_url',
        'updatedAt': 'updated_at',
        'stargazersCount': 'stargazers_count',
        'forksCount': 'forks_count',
        'watchersCount': 'watchers_count'
      },
    );

Map<String, dynamic> _$$_RepoToJson(_$_Repo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner.toJson(),
      'html_url': instance.htmlUrl,
      'description': instance.description,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'stargazers_count': instance.stargazersCount,
      'forks_count': instance.forksCount,
      'watchers_count': instance.watchersCount,
    };
