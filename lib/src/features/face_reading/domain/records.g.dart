// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'records.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RecordsImpl _$$RecordsImplFromJson(Map json) => _$RecordsImpl(
      faceReadings: (json['faceReadings'] as num?)?.toInt() ?? 0,
      timestamp:
          const TimestampConverter().fromJson(json['timestamp'] as Timestamp),
      remainingFaceReadings:
          (json['remainingFaceReadings'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$RecordsImplToJson(_$RecordsImpl instance) =>
    <String, dynamic>{
      'faceReadings': instance.faceReadings,
      'timestamp': const TimestampConverter().toJson(instance.timestamp),
      'remainingFaceReadings': instance.remainingFaceReadings,
    };
