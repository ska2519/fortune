// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'purchase.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Purchase _$PurchaseFromJson(Map<String, dynamic> json) {
  return _Purchase.fromJson(json);
}

/// @nodoc
mixin _$Purchase {
  @JsonKey(name: 'application_fee')
  String get applicationFee => throw _privateConstructorUsedError;
  int get quantity =>
      throw _privateConstructorUsedError; // Use double for decimal values
// ignore: invalid_annotation_target
  @JsonKey(
      name: 'created_at',
      fromJson: _timestampFromJson,
      toJson: _timestampToJson)
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'extra_amount')
  String get extraAmount =>
      throw _privateConstructorUsedError; // Use double for decimal values
  @JsonKey(name: 'extra_title')
  String get extraTitle => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'supporter_id')
  int get supporterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'supporter_email')
  String get supporterEmail => throw _privateConstructorUsedError;
  @JsonKey(name: 'supporter_name')
  String get supporterName => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_amount_charged')
  String get totalAmountCharged =>
      throw _privateConstructorUsedError; // Use double for decimal values
  @JsonKey(name: 'transaction_id')
  String get transactionId => throw _privateConstructorUsedError;
  @JsonKey(name: 'support_type')
  String get supportType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseCopyWith<Purchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseCopyWith<$Res> {
  factory $PurchaseCopyWith(Purchase value, $Res Function(Purchase) then) =
      _$PurchaseCopyWithImpl<$Res, Purchase>;
  @useResult
  $Res call(
      {@JsonKey(name: 'application_fee') String applicationFee,
      int quantity,
      @JsonKey(
          name: 'created_at',
          fromJson: _timestampFromJson,
          toJson: _timestampToJson)
      DateTime createdAt,
      String description,
      @JsonKey(name: 'extra_amount') String extraAmount,
      @JsonKey(name: 'extra_title') String extraTitle,
      String message,
      @JsonKey(name: 'supporter_id') int supporterId,
      @JsonKey(name: 'supporter_email') String supporterEmail,
      @JsonKey(name: 'supporter_name') String supporterName,
      @JsonKey(name: 'total_amount_charged') String totalAmountCharged,
      @JsonKey(name: 'transaction_id') String transactionId,
      @JsonKey(name: 'support_type') String supportType});
}

/// @nodoc
class _$PurchaseCopyWithImpl<$Res, $Val extends Purchase>
    implements $PurchaseCopyWith<$Res> {
  _$PurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationFee = null,
    Object? quantity = null,
    Object? createdAt = null,
    Object? description = null,
    Object? extraAmount = null,
    Object? extraTitle = null,
    Object? message = null,
    Object? supporterId = null,
    Object? supporterEmail = null,
    Object? supporterName = null,
    Object? totalAmountCharged = null,
    Object? transactionId = null,
    Object? supportType = null,
  }) {
    return _then(_value.copyWith(
      applicationFee: null == applicationFee
          ? _value.applicationFee
          : applicationFee // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      extraAmount: null == extraAmount
          ? _value.extraAmount
          : extraAmount // ignore: cast_nullable_to_non_nullable
              as String,
      extraTitle: null == extraTitle
          ? _value.extraTitle
          : extraTitle // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      supporterId: null == supporterId
          ? _value.supporterId
          : supporterId // ignore: cast_nullable_to_non_nullable
              as int,
      supporterEmail: null == supporterEmail
          ? _value.supporterEmail
          : supporterEmail // ignore: cast_nullable_to_non_nullable
              as String,
      supporterName: null == supporterName
          ? _value.supporterName
          : supporterName // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmountCharged: null == totalAmountCharged
          ? _value.totalAmountCharged
          : totalAmountCharged // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      supportType: null == supportType
          ? _value.supportType
          : supportType // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PurchaseImplCopyWith<$Res>
    implements $PurchaseCopyWith<$Res> {
  factory _$$PurchaseImplCopyWith(
          _$PurchaseImpl value, $Res Function(_$PurchaseImpl) then) =
      __$$PurchaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'application_fee') String applicationFee,
      int quantity,
      @JsonKey(
          name: 'created_at',
          fromJson: _timestampFromJson,
          toJson: _timestampToJson)
      DateTime createdAt,
      String description,
      @JsonKey(name: 'extra_amount') String extraAmount,
      @JsonKey(name: 'extra_title') String extraTitle,
      String message,
      @JsonKey(name: 'supporter_id') int supporterId,
      @JsonKey(name: 'supporter_email') String supporterEmail,
      @JsonKey(name: 'supporter_name') String supporterName,
      @JsonKey(name: 'total_amount_charged') String totalAmountCharged,
      @JsonKey(name: 'transaction_id') String transactionId,
      @JsonKey(name: 'support_type') String supportType});
}

/// @nodoc
class __$$PurchaseImplCopyWithImpl<$Res>
    extends _$PurchaseCopyWithImpl<$Res, _$PurchaseImpl>
    implements _$$PurchaseImplCopyWith<$Res> {
  __$$PurchaseImplCopyWithImpl(
      _$PurchaseImpl _value, $Res Function(_$PurchaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationFee = null,
    Object? quantity = null,
    Object? createdAt = null,
    Object? description = null,
    Object? extraAmount = null,
    Object? extraTitle = null,
    Object? message = null,
    Object? supporterId = null,
    Object? supporterEmail = null,
    Object? supporterName = null,
    Object? totalAmountCharged = null,
    Object? transactionId = null,
    Object? supportType = null,
  }) {
    return _then(_$PurchaseImpl(
      applicationFee: null == applicationFee
          ? _value.applicationFee
          : applicationFee // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      extraAmount: null == extraAmount
          ? _value.extraAmount
          : extraAmount // ignore: cast_nullable_to_non_nullable
              as String,
      extraTitle: null == extraTitle
          ? _value.extraTitle
          : extraTitle // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      supporterId: null == supporterId
          ? _value.supporterId
          : supporterId // ignore: cast_nullable_to_non_nullable
              as int,
      supporterEmail: null == supporterEmail
          ? _value.supporterEmail
          : supporterEmail // ignore: cast_nullable_to_non_nullable
              as String,
      supporterName: null == supporterName
          ? _value.supporterName
          : supporterName // ignore: cast_nullable_to_non_nullable
              as String,
      totalAmountCharged: null == totalAmountCharged
          ? _value.totalAmountCharged
          : totalAmountCharged // ignore: cast_nullable_to_non_nullable
              as String,
      transactionId: null == transactionId
          ? _value.transactionId
          : transactionId // ignore: cast_nullable_to_non_nullable
              as String,
      supportType: null == supportType
          ? _value.supportType
          : supportType // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PurchaseImpl implements _Purchase {
  const _$PurchaseImpl(
      {@JsonKey(name: 'application_fee') required this.applicationFee,
      required this.quantity,
      @JsonKey(
          name: 'created_at',
          fromJson: _timestampFromJson,
          toJson: _timestampToJson)
      required this.createdAt,
      required this.description,
      @JsonKey(name: 'extra_amount') required this.extraAmount,
      @JsonKey(name: 'extra_title') required this.extraTitle,
      required this.message,
      @JsonKey(name: 'supporter_id') required this.supporterId,
      @JsonKey(name: 'supporter_email') required this.supporterEmail,
      @JsonKey(name: 'supporter_name') required this.supporterName,
      @JsonKey(name: 'total_amount_charged') required this.totalAmountCharged,
      @JsonKey(name: 'transaction_id') required this.transactionId,
      @JsonKey(name: 'support_type') required this.supportType});

  factory _$PurchaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$PurchaseImplFromJson(json);

  @override
  @JsonKey(name: 'application_fee')
  final String applicationFee;
  @override
  final int quantity;
// Use double for decimal values
// ignore: invalid_annotation_target
  @override
  @JsonKey(
      name: 'created_at',
      fromJson: _timestampFromJson,
      toJson: _timestampToJson)
  final DateTime createdAt;
  @override
  final String description;
  @override
  @JsonKey(name: 'extra_amount')
  final String extraAmount;
// Use double for decimal values
  @override
  @JsonKey(name: 'extra_title')
  final String extraTitle;
  @override
  final String message;
  @override
  @JsonKey(name: 'supporter_id')
  final int supporterId;
  @override
  @JsonKey(name: 'supporter_email')
  final String supporterEmail;
  @override
  @JsonKey(name: 'supporter_name')
  final String supporterName;
  @override
  @JsonKey(name: 'total_amount_charged')
  final String totalAmountCharged;
// Use double for decimal values
  @override
  @JsonKey(name: 'transaction_id')
  final String transactionId;
  @override
  @JsonKey(name: 'support_type')
  final String supportType;

  @override
  String toString() {
    return 'Purchase(applicationFee: $applicationFee, quantity: $quantity, createdAt: $createdAt, description: $description, extraAmount: $extraAmount, extraTitle: $extraTitle, message: $message, supporterId: $supporterId, supporterEmail: $supporterEmail, supporterName: $supporterName, totalAmountCharged: $totalAmountCharged, transactionId: $transactionId, supportType: $supportType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PurchaseImpl &&
            (identical(other.applicationFee, applicationFee) ||
                other.applicationFee == applicationFee) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.extraAmount, extraAmount) ||
                other.extraAmount == extraAmount) &&
            (identical(other.extraTitle, extraTitle) ||
                other.extraTitle == extraTitle) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.supporterId, supporterId) ||
                other.supporterId == supporterId) &&
            (identical(other.supporterEmail, supporterEmail) ||
                other.supporterEmail == supporterEmail) &&
            (identical(other.supporterName, supporterName) ||
                other.supporterName == supporterName) &&
            (identical(other.totalAmountCharged, totalAmountCharged) ||
                other.totalAmountCharged == totalAmountCharged) &&
            (identical(other.transactionId, transactionId) ||
                other.transactionId == transactionId) &&
            (identical(other.supportType, supportType) ||
                other.supportType == supportType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      applicationFee,
      quantity,
      createdAt,
      description,
      extraAmount,
      extraTitle,
      message,
      supporterId,
      supporterEmail,
      supporterName,
      totalAmountCharged,
      transactionId,
      supportType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      __$$PurchaseImplCopyWithImpl<_$PurchaseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PurchaseImplToJson(
      this,
    );
  }
}

abstract class _Purchase implements Purchase {
  const factory _Purchase(
      {@JsonKey(name: 'application_fee') required final String applicationFee,
      required final int quantity,
      @JsonKey(
          name: 'created_at',
          fromJson: _timestampFromJson,
          toJson: _timestampToJson)
      required final DateTime createdAt,
      required final String description,
      @JsonKey(name: 'extra_amount') required final String extraAmount,
      @JsonKey(name: 'extra_title') required final String extraTitle,
      required final String message,
      @JsonKey(name: 'supporter_id') required final int supporterId,
      @JsonKey(name: 'supporter_email') required final String supporterEmail,
      @JsonKey(name: 'supporter_name') required final String supporterName,
      @JsonKey(name: 'total_amount_charged')
      required final String totalAmountCharged,
      @JsonKey(name: 'transaction_id') required final String transactionId,
      @JsonKey(name: 'support_type')
      required final String supportType}) = _$PurchaseImpl;

  factory _Purchase.fromJson(Map<String, dynamic> json) =
      _$PurchaseImpl.fromJson;

  @override
  @JsonKey(name: 'application_fee')
  String get applicationFee;
  @override
  int get quantity;
  @override // Use double for decimal values
// ignore: invalid_annotation_target
  @JsonKey(
      name: 'created_at',
      fromJson: _timestampFromJson,
      toJson: _timestampToJson)
  DateTime get createdAt;
  @override
  String get description;
  @override
  @JsonKey(name: 'extra_amount')
  String get extraAmount;
  @override // Use double for decimal values
  @JsonKey(name: 'extra_title')
  String get extraTitle;
  @override
  String get message;
  @override
  @JsonKey(name: 'supporter_id')
  int get supporterId;
  @override
  @JsonKey(name: 'supporter_email')
  String get supporterEmail;
  @override
  @JsonKey(name: 'supporter_name')
  String get supporterName;
  @override
  @JsonKey(name: 'total_amount_charged')
  String get totalAmountCharged;
  @override // Use double for decimal values
  @JsonKey(name: 'transaction_id')
  String get transactionId;
  @override
  @JsonKey(name: 'support_type')
  String get supportType;
  @override
  @JsonKey(ignore: true)
  _$$PurchaseImplCopyWith<_$PurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
