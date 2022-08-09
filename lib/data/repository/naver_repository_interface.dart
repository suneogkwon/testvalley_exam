import 'package:testvalley/data/model/product/product_model.dart';

abstract class INaverSearchRepo {
  /// [keyword]로 검색된 결과 중 상품 제목만 가져온다.
  Future<List<String>?> getSearchTitleList(String keyword);

  /// [keyword]로 검색한 결과를 가져온다.
  Future<ProductModelResponse?> getProductList({
    required String keyword,
    int start = 1,
  });
}
