import 'package:flutter/material.dart';

class SearchKeywordViewModel extends ChangeNotifier {
  /// 검색어
  String searchKeyword = '';

  void resetState() {
    searchKeyword = '';
  }
}
