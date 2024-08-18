// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'face_reading.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FaceReadingImpl _$$FaceReadingImplFromJson(Map json) => _$FaceReadingImpl(
      imageBytes:
          const Uint8ListConverter().fromJson(json['imageBytes'] as List<int>?),
      physiognomy: json['physiognomy'] as String,
      difficulties: (json['difficulties'] as List<dynamic>)
          .map((e) => Difficulty.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
      promisingJobs: (json['promisingJobs'] as List<dynamic>)
          .map(
              (e) => PromisingJob.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$$FaceReadingImplToJson(_$FaceReadingImpl instance) =>
    <String, dynamic>{
      'imageBytes': const Uint8ListConverter().toJson(instance.imageBytes),
      'physiognomy': instance.physiognomy,
      'difficulties': instance.difficulties.map((e) => e.toJson()).toList(),
      'promisingJobs': instance.promisingJobs.map((e) => e.toJson()).toList(),
    };

_$DifficultyImpl _$$DifficultyImplFromJson(Map json) => _$DifficultyImpl(
      level: (json['level'] as num?)?.toInt() ?? 0,
      job: json['job'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );

Map<String, dynamic> _$$DifficultyImplToJson(_$DifficultyImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'job': instance.job,
      'emoji': instance.emoji,
      'reason': instance.reason,
    };

_$PromisingJobImpl _$$PromisingJobImplFromJson(Map json) => _$PromisingJobImpl(
      job: json['job'] as String? ?? '',
      emoji: json['emoji'] as String? ?? '',
      expertise: (json['expertise'] as num?)?.toInt() ?? 0,
      expertStudyPeriod: json['expertStudyPeriod'] as String? ?? '',
      reason: json['reason'] as String? ?? '',
    );

Map<String, dynamic> _$$PromisingJobImplToJson(_$PromisingJobImpl instance) =>
    <String, dynamic>{
      'job': instance.job,
      'emoji': instance.emoji,
      'expertise': instance.expertise,
      'expertStudyPeriod': instance.expertStudyPeriod,
      'reason': instance.reason,
    };
