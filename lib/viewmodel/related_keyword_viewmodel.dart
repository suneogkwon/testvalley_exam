import 'package:flutter/material.dart';
import 'package:testvalley/data/repository/search_repository.dart';

class RelatedKeywordViewModel extends ChangeNotifier {
  final SearchRepository searchRepository = SearchRepository();

  /// 최근 검색어
  List<String> recentSearchKeywords = <String>[];

  /// 최근 검색어([recentSearchKeywords])를 비운다.
  void clearRecentSearchKeywords() {
    if (recentSearchKeywords.isEmpty) return;

    recentSearchKeywords.clear();
    notifyListeners();
  }

  /// 최근 검색어([recentSearchKeywords])에서 [index]번째 항목을 삭제한다.
  void removeSelectedKeyword(int index) {
    if (recentSearchKeywords.isEmpty) return;

    recentSearchKeywords.removeAt(index);
    notifyListeners();
  }
}
