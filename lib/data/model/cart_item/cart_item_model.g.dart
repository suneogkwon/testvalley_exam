// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      item: ProductModel.fromJson(json['item'] as Map<String, dynamic>),
      amount: json['amount'] as int? ?? 1,
      totalPrice: json['totalPrice'] as int? ?? 0,
      checked: json['checked'] as bool? ?? false,
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'item': instance.item,
      'amount': instance.amount,
      'totalPrice': instance.totalPrice,
      'checked': instance.checked,
    };
