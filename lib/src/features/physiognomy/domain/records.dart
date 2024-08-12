import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fortune/src/features/physiognomy/domain/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'records.freezed.dart';
part 'records.g.dart';

@freezed
class Records with _$Records {
  const Records._();
  const factory Records({
    @Default(0) int faceReadings,
    @TimestampConverter() required DateTime timestamp,
    @Default(0) int remainingFaceReadings,
  }) = _Records;

  factory Records.fromJson(Map<String, dynamic> json) =>
      _$RecordsFromJson(json);
}
