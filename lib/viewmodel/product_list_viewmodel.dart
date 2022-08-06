import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/model/product/product_model.dart';
import 'package:testvalley/data/repository/search_repository.dart';
import 'package:testvalley/viewmodel/search/search_viewmodel.dart';

class ProductListViewModel extends ChangeNotifier {
  ProductListViewModel() {
    pagingController.addPageRequestListener((pageKey) {
      loadProducts();
    });
  }

  final SearchRepository searchRepository = SearchRepository();

  final PagingController<int, ProductModel> pagingController =
      PagingController(firstPageKey: 0);

  /// 상품 리스트
  List<ProductModel> productList = [];

  /// 다음 키
  int nextPageKey = 1;

  @override
  void dispose() {
    pagingController.dispose();
    super.dispose();
  }

  void loadProducts() async {
    final String keyword = locator<SearchViewModel>().searchKeyword;

    final ProductModelResponse response = await searchRepository.getProducts(
      keyword: keyword,
      start: nextPageKey,
    );
    final bool isLast = response.start + 10 >= 1000;

    if (isLast) {
      pagingController.appendLastPage(response.productList);
    } else {
      nextPageKey += 10;
      pagingController.appendPage(response.productList, nextPageKey);
    }
  }
}
