import 'package:flutter/material.dart';
import 'package:testvalley/data/repository/search_repository.dart';

class SearchKeywordViewModel extends ChangeNotifier {
  final SearchRepository searchRepository = SearchRepository();

  /// 검색어
  String searchKeyword = '';

  void resetState() {
    searchKeyword = '';
  }

  void setSearchKeyword(String keyword) {
    searchKeyword = keyword;
  }
}
