// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'complete_voting_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CompleteVotingRequest _$$_CompleteVotingRequestFromJson(Map json) =>
    $checkedCreate(
      r'_$_CompleteVotingRequest',
      json,
      ($checkedConvert) {
        final val = _$_CompleteVotingRequest(
          userId: $checkedConvert('userId', (v) => v as String? ?? ''),
          completeVotingRequestId: $checkedConvert(
              'completeVotingRequestId', (v) => v as String? ?? ''),
          createdAt: $checkedConvert(
              'createdAt',
              (v) => v == null
                  ? const UnionTimestamp.serverTimestamp()
                  : unionTimestampConverter.fromJson(v as Object)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_CompleteVotingRequestToJson(
        _$_CompleteVotingRequest instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'completeVotingRequestId': instance.completeVotingRequestId,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
    };
