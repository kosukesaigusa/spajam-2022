// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint, implicit_dynamic_parameter, implicit_dynamic_type, implicit_dynamic_method, strict_raw_type, unnecessary_cast, todo

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Rooms _$$_RoomsFromJson(Map json) => $checkedCreate(
      r'_$_Rooms',
      json,
      ($checkedConvert) {
        final val = _$_Rooms(
          roomId: $checkedConvert('roomId', (v) => v as String? ?? ''),
          roomName: $checkedConvert('roomName', (v) => v as String? ?? ''),
          createdAt: $checkedConvert(
              'createdAt',
              (v) => v == null
                  ? const UnionTimestamp.serverTimestamp()
                  : unionTimestampConverter.fromJson(v as Object)),
          userIds: $checkedConvert(
              'userIds',
              (v) =>
                  (v as List<dynamic>?)?.map((e) => e as String).toList() ??
                  const <String>[]),
        );
        return val;
      },
    );

Map<String, dynamic> _$$_RoomsToJson(_$_Rooms instance) => <String, dynamic>{
      'roomId': instance.roomId,
      'roomName': instance.roomName,
      'createdAt': unionTimestampConverter.toJson(instance.createdAt),
      'userIds': instance.userIds,
    };
