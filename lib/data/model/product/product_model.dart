import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  ProductModel({
    required this.productId,
    required this.title,
    required this.link,
    required this.image,
    required this.lowestPrice,
    this.highestPrice = '0',
    required this.mallName,
    required this.maker,
    required this.brand,
    this.category1 = '',
    this.category2 = '',
    this.category3 = '',
    this.category4 = '',
  });

  final String productId;
  final String title;
  final String link;
  final String image;
  @JsonKey(name: 'lprice')
  final String lowestPrice;
  @JsonKey(name: 'hprice')
  final String highestPrice;
  final String mallName;
  final String maker;
  final String brand;
  final String category1;
  final String category2;
  final String category3;
  final String category4;

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}

@JsonSerializable()
class ProductModelResponse {
  ProductModelResponse({
    this.total = 0,
    this.start = 0,
    required this.productList,
  });

  final int total;
  final int start;
  @JsonKey(name: 'items')
  final List<ProductModel> productList;

  factory ProductModelResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelResponseToJson(this);
}
