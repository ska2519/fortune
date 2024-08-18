import 'dart:typed_data';

import 'package:fortune/src/features/face_reading/domain/uint8_list_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'face_reading.freezed.dart';
part 'face_reading.g.dart';

@freezed
class FaceReading with _$FaceReading {
  const factory FaceReading({
    @Uint8ListConverter() Uint8List? imageBytes,
    required String physiognomy,
    required List<Difficulty> difficulties,
    required List<PromisingJob> promisingJobs,
  }) = _FaceReading;

  factory FaceReading.fromJson(Map<String, dynamic> json) =>
      _$FaceReadingFromJson(json);
}

@freezed
class Difficulty with _$Difficulty {
  const factory Difficulty({
    @Default(0) int level,
    @Default('') String job,
    @Default('') String emoji,
    @Default('') String reason,
  }) = _Difficulty;

  factory Difficulty.fromJson(Map<String, dynamic> json) =>
      _$DifficultyFromJson(json);
}

@freezed
class PromisingJob with _$PromisingJob {
  const factory PromisingJob({
    @Default('') String job,
    @Default('') String emoji,
    @Default(0) int expertise,
    @Default('') String expertStudyPeriod,
    @Default('') String reason,
  }) = _PromisingJob;

  factory PromisingJob.fromJson(Map<String, dynamic> json) =>
      _$PromisingJobFromJson(json);
}
