// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'records.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Records _$RecordsFromJson(Map<String, dynamic> json) {
  return _Records.fromJson(json);
}

/// @nodoc
mixin _$Records {
  int get faceReadings => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RecordsCopyWith<Records> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecordsCopyWith<$Res> {
  factory $RecordsCopyWith(Records value, $Res Function(Records) then) =
      _$RecordsCopyWithImpl<$Res, Records>;
  @useResult
  $Res call({int faceReadings, @TimestampConverter() DateTime timestamp});
}

/// @nodoc
class _$RecordsCopyWithImpl<$Res, $Val extends Records>
    implements $RecordsCopyWith<$Res> {
  _$RecordsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faceReadings = null,
    Object? timestamp = null,
  }) {
    return _then(_value.copyWith(
      faceReadings: null == faceReadings
          ? _value.faceReadings
          : faceReadings // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecordsImplCopyWith<$Res> implements $RecordsCopyWith<$Res> {
  factory _$$RecordsImplCopyWith(
          _$RecordsImpl value, $Res Function(_$RecordsImpl) then) =
      __$$RecordsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int faceReadings, @TimestampConverter() DateTime timestamp});
}

/// @nodoc
class __$$RecordsImplCopyWithImpl<$Res>
    extends _$RecordsCopyWithImpl<$Res, _$RecordsImpl>
    implements _$$RecordsImplCopyWith<$Res> {
  __$$RecordsImplCopyWithImpl(
      _$RecordsImpl _value, $Res Function(_$RecordsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? faceReadings = null,
    Object? timestamp = null,
  }) {
    return _then(_$RecordsImpl(
      faceReadings: null == faceReadings
          ? _value.faceReadings
          : faceReadings // ignore: cast_nullable_to_non_nullable
              as int,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RecordsImpl extends _Records {
  const _$RecordsImpl(
      {this.faceReadings = 0, @TimestampConverter() required this.timestamp})
      : super._();

  factory _$RecordsImpl.fromJson(Map<String, dynamic> json) =>
      _$$RecordsImplFromJson(json);

  @override
  @JsonKey()
  final int faceReadings;
  @override
  @TimestampConverter()
  final DateTime timestamp;

  @override
  String toString() {
    return 'Records(faceReadings: $faceReadings, timestamp: $timestamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecordsImpl &&
            (identical(other.faceReadings, faceReadings) ||
                other.faceReadings == faceReadings) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, faceReadings, timestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RecordsImplCopyWith<_$RecordsImpl> get copyWith =>
      __$$RecordsImplCopyWithImpl<_$RecordsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RecordsImplToJson(
      this,
    );
  }
}

abstract class _Records extends Records {
  const factory _Records(
      {final int faceReadings,
      @TimestampConverter() required final DateTime timestamp}) = _$RecordsImpl;
  const _Records._() : super._();

  factory _Records.fromJson(Map<String, dynamic> json) = _$RecordsImpl.fromJson;

  @override
  int get faceReadings;
  @override
  @TimestampConverter()
  DateTime get timestamp;
  @override
  @JsonKey(ignore: true)
  _$$RecordsImplCopyWith<_$RecordsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
