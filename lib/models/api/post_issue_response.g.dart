// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'post_issue_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostIssueResponse _$$_PostIssueResponseFromJson(Map json) => $checkedCreate(
      r'_$_PostIssueResponse',
      json,
      ($checkedConvert) {
        final val = _$_PostIssueResponse(
          success: $checkedConvert('success', (v) => v as bool? ?? true),
          message: $checkedConvert('message', (v) => v as String? ?? ''),
          issue: $checkedConvert(
              'issue',
              (v) => v == null
                  ? Issue.defaultValue
                  : Issue.fromJson(Map<String, dynamic>.from(v as Map))),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_PostIssueResponseToJson(
        _$_PostIssueResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'issue': instance.issue.toJson(),
    };
