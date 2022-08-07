// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      item: ProductModel.fromJson(json['item'] as Map<String, dynamic>),
      amount: json['amount'] as int? ?? 1,
      totalPrice: json['totalAmount'] as int? ?? 0,
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) =>
    <String, dynamic>{
      'item': instance.item,
      'amount': instance.amount,
      'totalAmount': instance.totalPrice,
    };
