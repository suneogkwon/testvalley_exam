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

  /// 상품
  final ProductModel item;

  /// 상품갯수
  int amount;

  /// 총 가격
  int totalPrice;

  /// 장바구니 체크 여부
  bool checked;

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
