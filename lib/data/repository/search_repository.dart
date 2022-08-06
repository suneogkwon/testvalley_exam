import 'package:testvalley/data/api/search_api.dart';
import 'package:testvalley/data/model/product/product_model.dart';

class SearchRepository {
  final SearchApi searchApi = SearchApi();

  Future<ProductModelResponse> getProducts({
    required String keyword,
    int? start,
  }) async {
    final ProductModelResponse? data = await searchApi.getSearchList({
      'query': keyword,
      'start': '${start ?? 1}',
    });

    if (data == null) {
      return ProductModelResponse(productList: []);
    }

    return data;
  }

  Future<List<String>> getRelatedKeyword(String keyword) async {
    final ProductModelResponse? data = await searchApi.getSearchList({
      'query': keyword,
    });

    if (data == null) return [];

    final List<ProductModel> items = data.productList;
    final List<String> titleList = <String>[];

    for (ProductModel item in items) {
      titleList.add(item.title);
    }

    return titleList;
  }
}
