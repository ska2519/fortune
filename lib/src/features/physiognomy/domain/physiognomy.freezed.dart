// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'physiognomy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Physiognomy _$PhysiognomyFromJson(Map<String, dynamic> json) {
  return _Physiognomy.fromJson(json);
}

/// @nodoc
mixin _$Physiognomy {
  @Uint8ListConverter()
  Uint8List? get imageBytes => throw _privateConstructorUsedError;
  String get physiognomy => throw _privateConstructorUsedError;
  List<Difficulty> get difficulties => throw _privateConstructorUsedError;
  List<PromisingJob> get promisingJobs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PhysiognomyCopyWith<Physiognomy> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PhysiognomyCopyWith<$Res> {
  factory $PhysiognomyCopyWith(
          Physiognomy value, $Res Function(Physiognomy) then) =
      _$PhysiognomyCopyWithImpl<$Res, Physiognomy>;
  @useResult
  $Res call(
      {@Uint8ListConverter() Uint8List? imageBytes,
      String physiognomy,
      List<Difficulty> difficulties,
      List<PromisingJob> promisingJobs});
}

/// @nodoc
class _$PhysiognomyCopyWithImpl<$Res, $Val extends Physiognomy>
    implements $PhysiognomyCopyWith<$Res> {
  _$PhysiognomyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageBytes = freezed,
    Object? physiognomy = null,
    Object? difficulties = null,
    Object? promisingJobs = null,
  }) {
    return _then(_value.copyWith(
      imageBytes: freezed == imageBytes
          ? _value.imageBytes
          : imageBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      physiognomy: null == physiognomy
          ? _value.physiognomy
          : physiognomy // ignore: cast_nullable_to_non_nullable
              as String,
      difficulties: null == difficulties
          ? _value.difficulties
          : difficulties // ignore: cast_nullable_to_non_nullable
              as List<Difficulty>,
      promisingJobs: null == promisingJobs
          ? _value.promisingJobs
          : promisingJobs // ignore: cast_nullable_to_non_nullable
              as List<PromisingJob>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PhysiognomyImplCopyWith<$Res>
    implements $PhysiognomyCopyWith<$Res> {
  factory _$$PhysiognomyImplCopyWith(
          _$PhysiognomyImpl value, $Res Function(_$PhysiognomyImpl) then) =
      __$$PhysiognomyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@Uint8ListConverter() Uint8List? imageBytes,
      String physiognomy,
      List<Difficulty> difficulties,
      List<PromisingJob> promisingJobs});
}

/// @nodoc
class __$$PhysiognomyImplCopyWithImpl<$Res>
    extends _$PhysiognomyCopyWithImpl<$Res, _$PhysiognomyImpl>
    implements _$$PhysiognomyImplCopyWith<$Res> {
  __$$PhysiognomyImplCopyWithImpl(
      _$PhysiognomyImpl _value, $Res Function(_$PhysiognomyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? imageBytes = freezed,
    Object? physiognomy = null,
    Object? difficulties = null,
    Object? promisingJobs = null,
  }) {
    return _then(_$PhysiognomyImpl(
      imageBytes: freezed == imageBytes
          ? _value.imageBytes
          : imageBytes // ignore: cast_nullable_to_non_nullable
              as Uint8List?,
      physiognomy: null == physiognomy
          ? _value.physiognomy
          : physiognomy // ignore: cast_nullable_to_non_nullable
              as String,
      difficulties: null == difficulties
          ? _value._difficulties
          : difficulties // ignore: cast_nullable_to_non_nullable
              as List<Difficulty>,
      promisingJobs: null == promisingJobs
          ? _value._promisingJobs
          : promisingJobs // ignore: cast_nullable_to_non_nullable
              as List<PromisingJob>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PhysiognomyImpl implements _Physiognomy {
  const _$PhysiognomyImpl(
      {@Uint8ListConverter() this.imageBytes,
      required this.physiognomy,
      required final List<Difficulty> difficulties,
      required final List<PromisingJob> promisingJobs})
      : _difficulties = difficulties,
        _promisingJobs = promisingJobs;

  factory _$PhysiognomyImpl.fromJson(Map<String, dynamic> json) =>
      _$$PhysiognomyImplFromJson(json);

  @override
  @Uint8ListConverter()
  final Uint8List? imageBytes;
  @override
  final String physiognomy;
  final List<Difficulty> _difficulties;
  @override
  List<Difficulty> get difficulties {
    if (_difficulties is EqualUnmodifiableListView) return _difficulties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_difficulties);
  }

  final List<PromisingJob> _promisingJobs;
  @override
  List<PromisingJob> get promisingJobs {
    if (_promisingJobs is EqualUnmodifiableListView) return _promisingJobs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_promisingJobs);
  }

  @override
  String toString() {
    return 'Physiognomy(imageBytes: $imageBytes, physiognomy: $physiognomy, difficulties: $difficulties, promisingJobs: $promisingJobs)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PhysiognomyImpl &&
            const DeepCollectionEquality()
                .equals(other.imageBytes, imageBytes) &&
            (identical(other.physiognomy, physiognomy) ||
                other.physiognomy == physiognomy) &&
            const DeepCollectionEquality()
                .equals(other._difficulties, _difficulties) &&
            const DeepCollectionEquality()
                .equals(other._promisingJobs, _promisingJobs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(imageBytes),
      physiognomy,
      const DeepCollectionEquality().hash(_difficulties),
      const DeepCollectionEquality().hash(_promisingJobs));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PhysiognomyImplCopyWith<_$PhysiognomyImpl> get copyWith =>
      __$$PhysiognomyImplCopyWithImpl<_$PhysiognomyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PhysiognomyImplToJson(
      this,
    );
  }
}

abstract class _Physiognomy implements Physiognomy {
  const factory _Physiognomy(
      {@Uint8ListConverter() final Uint8List? imageBytes,
      required final String physiognomy,
      required final List<Difficulty> difficulties,
      required final List<PromisingJob> promisingJobs}) = _$PhysiognomyImpl;

  factory _Physiognomy.fromJson(Map<String, dynamic> json) =
      _$PhysiognomyImpl.fromJson;

  @override
  @Uint8ListConverter()
  Uint8List? get imageBytes;
  @override
  String get physiognomy;
  @override
  List<Difficulty> get difficulties;
  @override
  List<PromisingJob> get promisingJobs;
  @override
  @JsonKey(ignore: true)
  _$$PhysiognomyImplCopyWith<_$PhysiognomyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Difficulty _$DifficultyFromJson(Map<String, dynamic> json) {
  return _Difficulty.fromJson(json);
}

/// @nodoc
mixin _$Difficulty {
  int get level => throw _privateConstructorUsedError;
  String get job => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DifficultyCopyWith<Difficulty> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DifficultyCopyWith<$Res> {
  factory $DifficultyCopyWith(
          Difficulty value, $Res Function(Difficulty) then) =
      _$DifficultyCopyWithImpl<$Res, Difficulty>;
  @useResult
  $Res call({int level, String job, String emoji, String reason});
}

/// @nodoc
class _$DifficultyCopyWithImpl<$Res, $Val extends Difficulty>
    implements $DifficultyCopyWith<$Res> {
  _$DifficultyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? job = null,
    Object? emoji = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DifficultyImplCopyWith<$Res>
    implements $DifficultyCopyWith<$Res> {
  factory _$$DifficultyImplCopyWith(
          _$DifficultyImpl value, $Res Function(_$DifficultyImpl) then) =
      __$$DifficultyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int level, String job, String emoji, String reason});
}

/// @nodoc
class __$$DifficultyImplCopyWithImpl<$Res>
    extends _$DifficultyCopyWithImpl<$Res, _$DifficultyImpl>
    implements _$$DifficultyImplCopyWith<$Res> {
  __$$DifficultyImplCopyWithImpl(
      _$DifficultyImpl _value, $Res Function(_$DifficultyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? job = null,
    Object? emoji = null,
    Object? reason = null,
  }) {
    return _then(_$DifficultyImpl(
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as int,
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DifficultyImpl implements _Difficulty {
  const _$DifficultyImpl(
      {required this.level,
      required this.job,
      required this.emoji,
      required this.reason});

  factory _$DifficultyImpl.fromJson(Map<String, dynamic> json) =>
      _$$DifficultyImplFromJson(json);

  @override
  final int level;
  @override
  final String job;
  @override
  final String emoji;
  @override
  final String reason;

  @override
  String toString() {
    return 'Difficulty(level: $level, job: $job, emoji: $emoji, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DifficultyImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, level, job, emoji, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DifficultyImplCopyWith<_$DifficultyImpl> get copyWith =>
      __$$DifficultyImplCopyWithImpl<_$DifficultyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DifficultyImplToJson(
      this,
    );
  }
}

abstract class _Difficulty implements Difficulty {
  const factory _Difficulty(
      {required final int level,
      required final String job,
      required final String emoji,
      required final String reason}) = _$DifficultyImpl;

  factory _Difficulty.fromJson(Map<String, dynamic> json) =
      _$DifficultyImpl.fromJson;

  @override
  int get level;
  @override
  String get job;
  @override
  String get emoji;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$DifficultyImplCopyWith<_$DifficultyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PromisingJob _$PromisingJobFromJson(Map<String, dynamic> json) {
  return _PromisingJob.fromJson(json);
}

/// @nodoc
mixin _$PromisingJob {
  String get job => throw _privateConstructorUsedError;
  String get emoji => throw _privateConstructorUsedError;
  int get expertise => throw _privateConstructorUsedError;
  String get expertStudyPeriod => throw _privateConstructorUsedError;
  String get reason => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromisingJobCopyWith<PromisingJob> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromisingJobCopyWith<$Res> {
  factory $PromisingJobCopyWith(
          PromisingJob value, $Res Function(PromisingJob) then) =
      _$PromisingJobCopyWithImpl<$Res, PromisingJob>;
  @useResult
  $Res call(
      {String job,
      String emoji,
      int expertise,
      String expertStudyPeriod,
      String reason});
}

/// @nodoc
class _$PromisingJobCopyWithImpl<$Res, $Val extends PromisingJob>
    implements $PromisingJobCopyWith<$Res> {
  _$PromisingJobCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? emoji = null,
    Object? expertise = null,
    Object? expertStudyPeriod = null,
    Object? reason = null,
  }) {
    return _then(_value.copyWith(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      expertise: null == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as int,
      expertStudyPeriod: null == expertStudyPeriod
          ? _value.expertStudyPeriod
          : expertStudyPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PromisingJobImplCopyWith<$Res>
    implements $PromisingJobCopyWith<$Res> {
  factory _$$PromisingJobImplCopyWith(
          _$PromisingJobImpl value, $Res Function(_$PromisingJobImpl) then) =
      __$$PromisingJobImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String job,
      String emoji,
      int expertise,
      String expertStudyPeriod,
      String reason});
}

/// @nodoc
class __$$PromisingJobImplCopyWithImpl<$Res>
    extends _$PromisingJobCopyWithImpl<$Res, _$PromisingJobImpl>
    implements _$$PromisingJobImplCopyWith<$Res> {
  __$$PromisingJobImplCopyWithImpl(
      _$PromisingJobImpl _value, $Res Function(_$PromisingJobImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? job = null,
    Object? emoji = null,
    Object? expertise = null,
    Object? expertStudyPeriod = null,
    Object? reason = null,
  }) {
    return _then(_$PromisingJobImpl(
      job: null == job
          ? _value.job
          : job // ignore: cast_nullable_to_non_nullable
              as String,
      emoji: null == emoji
          ? _value.emoji
          : emoji // ignore: cast_nullable_to_non_nullable
              as String,
      expertise: null == expertise
          ? _value.expertise
          : expertise // ignore: cast_nullable_to_non_nullable
              as int,
      expertStudyPeriod: null == expertStudyPeriod
          ? _value.expertStudyPeriod
          : expertStudyPeriod // ignore: cast_nullable_to_non_nullable
              as String,
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PromisingJobImpl implements _PromisingJob {
  const _$PromisingJobImpl(
      {required this.job,
      required this.emoji,
      required this.expertise,
      required this.expertStudyPeriod,
      required this.reason});

  factory _$PromisingJobImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromisingJobImplFromJson(json);

  @override
  final String job;
  @override
  final String emoji;
  @override
  final int expertise;
  @override
  final String expertStudyPeriod;
  @override
  final String reason;

  @override
  String toString() {
    return 'PromisingJob(job: $job, emoji: $emoji, expertise: $expertise, expertStudyPeriod: $expertStudyPeriod, reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromisingJobImpl &&
            (identical(other.job, job) || other.job == job) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.expertise, expertise) ||
                other.expertise == expertise) &&
            (identical(other.expertStudyPeriod, expertStudyPeriod) ||
                other.expertStudyPeriod == expertStudyPeriod) &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, job, emoji, expertise, expertStudyPeriod, reason);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromisingJobImplCopyWith<_$PromisingJobImpl> get copyWith =>
      __$$PromisingJobImplCopyWithImpl<_$PromisingJobImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromisingJobImplToJson(
      this,
    );
  }
}

abstract class _PromisingJob implements PromisingJob {
  const factory _PromisingJob(
      {required final String job,
      required final String emoji,
      required final int expertise,
      required final String expertStudyPeriod,
      required final String reason}) = _$PromisingJobImpl;

  factory _PromisingJob.fromJson(Map<String, dynamic> json) =
      _$PromisingJobImpl.fromJson;

  @override
  String get job;
  @override
  String get emoji;
  @override
  int get expertise;
  @override
  String get expertStudyPeriod;
  @override
  String get reason;
  @override
  @JsonKey(ignore: true)
  _$$PromisingJobImplCopyWith<_$PromisingJobImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
