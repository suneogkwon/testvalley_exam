import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/api/api_response.dart';
import 'package:testvalley/data/api/naver_api_interface.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/data/repository/naver_repository_interface.dart';

class NaverSearchRepo implements INaverSearchRepo {
  final INaverSearchApi searchApi = locator<INaverSearchApi>();

  @override
  Future<ProductModelResponse> getProductList({
    required String keyword,
    int? start,
  }) async {
    final ApiResponse response = await searchApi.getShoppingSearchResult(
      query: {
        'query': keyword,
        'start': start,
      },
    );
    ProductModelResponse products = ProductModelResponse(productList: []);

    if (response.isAllPass()) {
      products = ProductModelResponse.fromJson(response.data);
    }
    return products;
  }

  @override
  Future<List<String>?> getSearchTitleList(String keyword) async {
    final ApiResponse response = await searchApi.getShoppingSearchResult(
      query: {'query': keyword},
    );

    final List<String> titleList = [];

    if (!response.isSuccess()) return null;

    if (response.existData()) {
      final ProductModelResponse products =
          ProductModelResponse.fromJson(response.data);

      for (ProductModel element in products.productList) {
        titleList.add(element.title);
      }
    }

    return titleList;
  }
}
