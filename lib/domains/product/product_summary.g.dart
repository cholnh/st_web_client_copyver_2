// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSummary _$ProductSummaryFromJson(Map<String, dynamic> json) {
  return ProductSummary(
    idx: json['idx'] as int,
    salePrice: json['salePrice'] as int,
    name: json['name'] as String,
    productImageMainPath: json['productImageMainPath'] as String,
  );
}

Map<String, dynamic> _$ProductSummaryToJson(ProductSummary instance) =>
    <String, dynamic>{
      'idx': instance.idx,
      'salePrice': instance.salePrice,
      'name': instance.name,
      'productImageMainPath': instance.productImageMainPath,
    };
