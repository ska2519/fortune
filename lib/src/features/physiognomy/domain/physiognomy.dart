import 'dart:typed_data';

import 'package:fortune/src/features/physiognomy/domain/uint8_list_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'physiognomy.freezed.dart';
part 'physiognomy.g.dart';

@freezed
class Physiognomy with _$Physiognomy {
  const factory Physiognomy({
    @Uint8ListConverter() Uint8List? imageBytes,
    required String physiognomy,
    required List<Difficulty> difficulties,
    required List<PromisingJob> promisingJobs,
  }) = _Physiognomy;

  factory Physiognomy.fromJson(Map<String, dynamic> json) =>
      _$PhysiognomyFromJson(json);
}

@freezed
class Difficulty with _$Difficulty {
  const factory Difficulty({
    required int level,
    required String job,
    required String emoji,
    required String reason,
  }) = _Difficulty;

  factory Difficulty.fromJson(Map<String, dynamic> json) =>
      _$DifficultyFromJson(json);
}

@freezed
class PromisingJob with _$PromisingJob {
  const factory PromisingJob({
    required String job,
     required String emoji,
    required int expertise,
    required String expertStudyPeriod,
    required String reason,
  }) = _PromisingJob;

  factory PromisingJob.fromJson(Map<String, dynamic> json) =>
      _$PromisingJobFromJson(json);
}
