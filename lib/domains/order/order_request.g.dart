// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRequest _$OrderRequestFromJson(Map<String, dynamic> json) {
  return OrderRequest(
    orderDate: json['orderDate'] == null
        ? null
        : DateTime.parse(json['orderDate'] as String),
    idxOrderTime: json['idxOrderTime'] as int,
    idxDeliveryDetailSite: json['idxDeliveryDetailSite'] as int,
    idxFcmToken: json['idxFcmToken'] as int,
    paymentType:
        _$enumDecodeNullable(_$PaymentTypeEnumMap, json['paymentType']),
    usingPoint: json['usingPoint'] as int,
    usingCouponCode: json['usingCouponCode'] as String,
    idxesUsingCoupons:
        (json['idxesUsingCoupons'] as List)?.map((e) => e as int)?.toSet(),
    idxesUsingPromotions:
        (json['idxesUsingPromotions'] as List)?.map((e) => e as int)?.toSet(),
    cashReceipt: json['cashReceipt'] as String,
    cashReceiptType:
        _$enumDecodeNullable(_$CashReceiptTypeEnumMap, json['cashReceiptType']),
    orderItems: (json['orderItems'] as List)
        ?.map((e) => e == null
            ? null
            : OrderItemRequest.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$OrderRequestToJson(OrderRequest instance) =>
    <String, dynamic>{
      'orderDate': instance.orderDate?.toIso8601String(),
      'idxOrderTime': instance.idxOrderTime,
      'idxDeliveryDetailSite': instance.idxDeliveryDetailSite,
      'idxFcmToken': instance.idxFcmToken,
      'paymentType': _$PaymentTypeEnumMap[instance.paymentType],
      'usingPoint': instance.usingPoint,
      'usingCouponCode': instance.usingCouponCode,
      'idxesUsingCoupons': instance.idxesUsingCoupons?.toList(),
      'idxesUsingPromotions': instance.idxesUsingPromotions?.toList(),
      'cashReceipt': instance.cashReceipt,
      'cashReceiptType': _$CashReceiptTypeEnumMap[instance.cashReceiptType],
      'orderItems': instance.orderItems?.map((e) => e?.toJson())?.toList(),
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$PaymentTypeEnumMap = {
  PaymentType.COMMON_CREDIT_CARD: 'COMMON_CREDIT_CARD',
  PaymentType.COMMON_PHONE: 'COMMON_PHONE',
  PaymentType.COMMON_V_BANK: 'COMMON_V_BANK',
  PaymentType.COMMON_KAKAOPAY: 'COMMON_KAKAOPAY',
  PaymentType.COMMON_REMOTE_PAY: 'COMMON_REMOTE_PAY',
  PaymentType.PERIODIC_CREDIT_CARD: 'PERIODIC_CREDIT_CARD',
  PaymentType.PERIODIC_FIRM_BANK: 'PERIODIC_FIRM_BANK',
};

const _$CashReceiptTypeEnumMap = {
  CashReceiptType.PERSONAL_PHONE_NUMBER: 'PERSONAL_PHONE_NUMBER',
  CashReceiptType.PERSONAL_CARD_NUMBER: 'PERSONAL_CARD_NUMBER',
  CashReceiptType.BUSINESS_REGISTRATION_NUMBER: 'BUSINESS_REGISTRATION_NUMBER',
  CashReceiptType.BUSINESS_CARD_NUMBER: 'BUSINESS_CARD_NUMBER',
};
