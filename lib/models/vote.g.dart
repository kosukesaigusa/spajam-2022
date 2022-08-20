// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'vote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Vote _$$_VoteFromJson(Map json) => $checkedCreate(
      r'_$_Vote',
      json,
      ($checkedConvert) {
        final val = _$_Vote(
          userId: $checkedConvert('userId', (v) => v as String? ?? ''),
          vote: $checkedConvert(
              'vote',
              (v) =>
                  $enumDecodeNullable(_$VoteEnumEnumMap, v) ??
                  VoteEnum.comfortable),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_VoteToJson(_$_Vote instance) => <String, dynamic>{
      'userId': instance.userId,
      'vote': _$VoteEnumEnumMap[instance.vote]!,
    };

const _$VoteEnumEnumMap = {
  VoteEnum.extremelyHot: 'extremelyHot',
  VoteEnum.hot: 'hot',
  VoteEnum.comfortable: 'comfortable',
  VoteEnum.cold: 'cold',
  VoteEnum.extremelyCold: 'extremelyCold',
};
