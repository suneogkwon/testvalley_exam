import 'package:json_annotation/json_annotation.dart';
import 'package:testvalley/data/model/product/product_model.dart';

part 'cart_item_model.g.dart';

@JsonSerializable()
class CartItemModel {
  CartItemModel({
    required this.item,
    this.amount = 1,
    this.totalPrice = 0,
    this.checked = false,
  });

  final ProductModel item;
  int amount;
  int totalPrice;
  bool checked;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
