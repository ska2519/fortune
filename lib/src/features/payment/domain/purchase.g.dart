// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PurchaseImpl _$$PurchaseImplFromJson(Map json) => _$PurchaseImpl(
      applicationFee: json['application_fee'] as String,
      quantity: (json['quantity'] as num).toInt(),
      createdAt: _timestampFromJson((json['created_at'] as num).toInt()),
      description: json['description'] as String,
      extraAmount: json['extra_amount'] as String,
      extraTitle: json['extra_title'] as String,
      message: json['message'] as String,
      supporterId: (json['supporter_id'] as num).toInt(),
      supporterEmail: json['supporter_email'] as String,
      supporterName: json['supporter_name'] as String,
      totalAmountCharged: json['total_amount_charged'] as String,
      transactionId: json['transaction_id'] as String,
      supportType: json['support_type'] as String,
    );

Map<String, dynamic> _$$PurchaseImplToJson(_$PurchaseImpl instance) =>
    <String, dynamic>{
      'application_fee': instance.applicationFee,
      'quantity': instance.quantity,
      'created_at': _timestampToJson(instance.createdAt),
      'description': instance.description,
      'extra_amount': instance.extraAmount,
      'extra_title': instance.extraTitle,
      'message': instance.message,
      'supporter_id': instance.supporterId,
      'supporter_email': instance.supporterEmail,
      'supporter_name': instance.supporterName,
      'total_amount_charged': instance.totalAmountCharged,
      'transaction_id': instance.transactionId,
      'support_type': instance.supportType,
    };
