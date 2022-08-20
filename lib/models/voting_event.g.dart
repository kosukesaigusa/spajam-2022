// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'voting_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_VotingEvent _$$_VotingEventFromJson(Map json) => $checkedCreate(
      r'_$_VotingEvent',
      json,
      ($checkedConvert) {
        final val = _$_VotingEvent(
          votingEventId:
              $checkedConvert('votingEventId', (v) => v as String? ?? ''),
          votingUserIds: $checkedConvert(
              'votingUserIds',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const <String>[]),
          status: $checkedConvert(
              'status',
              (v) =>
                  $enumDecodeNullable(_$VotingEventStatusEnumMap, v) ??
                  VotingEventStatus.peace),
          result: $checkedConvert(
              'result',
              (v) =>
                  $enumDecodeNullable(_$VoteEnumEnumMap, v) ??
                  VoteEnum.comfortable),
          feelings: $checkedConvert(
              'feelings',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          Feeling.fromJson(Map<String, dynamic>.from(e as Map)))
                      .toList() ??
                  const <Feeling>[]),
          votes: $checkedConvert(
              'votes',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) =>
                          Vote.fromJson(Map<String, dynamic>.from(e as Map)))
                      .toList() ??
                  const <Vote>[]),
          createdAt: $checkedConvert(
              'createdAt',
              (v) => v == null
                  ? const UnionTimestamp.serverTimestamp()
                  : unionTimestampConverter.fromJson(v as Object)),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_VotingEventToJson(_$_VotingEvent instance) =>
    <String, dynamic>{
      'votingEventId': instance.votingEventId,
      'votingUserIds': instance.votingUserIds,
      'status': _$VotingEventStatusEnumMap[instance.status]!,
      'result': _$VoteEnumEnumMap[instance.result]!,
      'feelings': instance.feelings.map((e) => e.toJson()).toList(),
      'votes': instance.votes.map((e) => e.toJson()).toList(),
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
    };

const _$VotingEventStatusEnumMap = {
  VotingEventStatus.peace: 'peace',
  VotingEventStatus.waiting: 'waiting',
  VotingEventStatus.voting: 'voting',
  VotingEventStatus.finished: 'finished',
};

const _$VoteEnumEnumMap = {
  VoteEnum.extremelyHot: 'extremelyHot',
  VoteEnum.hot: 'hot',
  VoteEnum.comfortable: 'comfortable',
  VoteEnum.cold: 'cold',
  VoteEnum.extremelyCold: 'extremelyCold',
};
