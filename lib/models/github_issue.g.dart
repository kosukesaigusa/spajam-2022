// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'github_issue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GithubIssue _$$_GithubIssueFromJson(Map json) => $checkedCreate(
      r'_$_GithubIssue',
      json,
      ($checkedConvert) {
        final val = _$_GithubIssue(
          id: $checkedConvert('id', (v) => v as int? ?? 0),
          number: $checkedConvert('number', (v) => v as int? ?? 0),
          title: $checkedConvert('title', (v) => v as String? ?? ''),
          htmlUrl: $checkedConvert('html_url', (v) => v as String? ?? ''),
          state: $checkedConvert('state', (v) => v as String? ?? ''),
          description:
              $checkedConvert('description', (v) => v as String? ?? ''),
          body: $checkedConvert('body', (v) => v as String? ?? ''),
          comments: $checkedConvert('comments', (v) => v as int? ?? 0),
          assignee: $checkedConvert('assignee', (v) => v as String?),
          assignees: $checkedConvert('assignees',
              (v) => (v as List<dynamic>?)?.map((e) => e as String).toList()),
          updatedAt: $checkedConvert('updated_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
          closedAt: $checkedConvert('closed_at',
              (v) => v == null ? null : DateTime.parse(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'htmlUrl': 'html_url',
        'updatedAt': 'updated_at',
        'closedAt': 'closed_at'
      },
    );

Map<String, dynamic> _$$_GithubIssueToJson(_$_GithubIssue instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'title': instance.title,
      'html_url': instance.htmlUrl,
      'state': instance.state,
      'description': instance.description,
      'body': instance.body,
      'comments': instance.comments,
      'assignee': instance.assignee,
      'assignees': instance.assignees,
      'updated_at': instance.updatedAt?.toIso8601String(),
      'closed_at': instance.closedAt?.toIso8601String(),
    };
