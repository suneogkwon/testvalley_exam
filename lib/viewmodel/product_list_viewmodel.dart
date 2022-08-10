import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/data/repository/naver/search_repository.dart';

class ProductListViewModel extends ChangeNotifier {
  final NaverSearchRepo _searchRepo = NaverSearchRepo();

  final PagingController<int, ProductModel> pagingController =
      PagingController(firstPageKey: 1);

  /// 다음 키
  int nextPageKey = 1;

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void addPagingListener(String keyword) {
    pagingController.addPageRequestListener((_) {
      loadProducts(keyword: keyword);
    });
  }

  void loadProducts({
    required String keyword,
    bool initial = false,
  }) async {
    final ProductModelResponse response = await _searchRepo.getProductList(
      keyword: keyword,
      start: nextPageKey,
    );
    final bool isLast = response.start + 10 >= 1000;

    if (initial) {
      pagingController.refresh();
      return;
    }

    if (isLast) {
      pagingController.appendLastPage(response.productList);
    } else {
      nextPageKey += 10;
      pagingController.appendPage(response.productList, nextPageKey);
    }
  }
}
