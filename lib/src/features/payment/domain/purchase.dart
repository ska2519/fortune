import 'package:freezed_annotation/freezed_annotation.dart';

part 'purchase.freezed.dart';
part 'purchase.g.dart';

@freezed
abstract class Purchase with _$Purchase {
  const factory Purchase({
    @JsonKey(name: 'application_fee') required String applicationFee,
    required int quantity, // Use double for decimal values
    // ignore: invalid_annotation_target
    @JsonKey(
        name: 'created_at',
        fromJson: _timestampFromJson,
        toJson: _timestampToJson)
    required DateTime createdAt,
    required String description,
    @JsonKey(name: 'extra_amount')
    required String extraAmount, // Use double for decimal values
    @JsonKey(name: 'extra_title') required String extraTitle,
    required String message,
    @JsonKey(name: 'supporter_id') required int supporterId,
    @JsonKey(name: 'supporter_email') required String supporterEmail,
    @JsonKey(name: 'supporter_name') required String supporterName,
    @JsonKey(name: 'total_amount_charged')
    required String totalAmountCharged, // Use double for decimal values
    @JsonKey(name: 'transaction_id') required String transactionId,
    @JsonKey(name: 'support_type') required String supportType,
  }) = _Purchase;

  factory Purchase.fromJson(Map<String, dynamic> json) =>
      _$PurchaseFromJson(json);
}

// Custom converters for timestamps
DateTime _timestampFromJson(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

int _timestampToJson(DateTime timestamp) {
  return timestamp.millisecondsSinceEpoch;
  ;
}

// Run this command to generate the necessary .g.dart file
// flutter pub run build_runner build --release