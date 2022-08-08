import 'package:flutter/material.dart';
import 'package:testvalley/config/navigator_util.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/config/storage_util.dart';

class SearchKeywordViewModel extends ChangeNotifier {
  /// 검색어
  String searchKeyword = '';

  void resetState() {
    searchKeyword = '';
  }

  void setSearchKeyword(String keyword) {
    searchKeyword = keyword;
  }

  void searchProduct(String? keyword) {
    if (keyword != null && keyword != '') {
      final List<String> recentKeywordList =
          Pref().storage.getStringList(Pref.recentKeyword) ?? [];

      recentKeywordList.insert(0, keyword);

      Pref().storage.setStringList(
            Pref.recentKeyword,
            recentKeywordList,
          );

      locator<AppNavigator>().pushNamed(
        AppRoutes.productList,
        arguments: keyword,
      );
    }
  }
}
