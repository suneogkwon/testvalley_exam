// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      productId: json['productId'] as String,
      title: json['title'] as String,
      link: json['link'] as String,
      image: json['image'] as String,
      lowestPrice: json['lprice'] as String,
      highestPrice: json['hprice'] as String? ?? '0',
      mallName: json['mallName'] as String,
      maker: json['maker'] as String,
      brand: json['brand'] as String,
      category1: json['category1'] as String? ?? '',
      category2: json['category2'] as String? ?? '',
      category3: json['category3'] as String? ?? '',
      category4: json['category4'] as String? ?? '',
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'title': instance.title,
      'link': instance.link,
      'image': instance.image,
      'lprice': instance.lowestPrice,
      'hprice': instance.highestPrice,
      'mallName': instance.mallName,
      'maker': instance.maker,
      'brand': instance.brand,
      'category1': instance.category1,
      'category2': instance.category2,
      'category3': instance.category3,
      'category4': instance.category4,
    };

ProductModelResponse _$ProductModelResponseFromJson(
        Map<String, dynamic> json) =>
    ProductModelResponse(
      total: json['total'] as int? ?? 0,
      start: json['start'] as int? ?? 0,
      productList: (json['items'] as List<dynamic>)
          .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductModelResponseToJson(
        ProductModelResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'start': instance.start,
      'items': instance.productList,
    };
