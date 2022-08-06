import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testvalley/config/routes.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/repository/search_repository.dart';

class SearchViewModel extends ChangeNotifier {
  final SearchRepository searchRepository = SearchRepository();

  /// 검색어
  String searchKeyword = '';

  /// 최근 검색어
  List<String> recentSearchKeywords = <String>[];

  /// 연관 검색어 리스트
  List<String> relatedKeywords = <String>[];

  // API 조회 간격용 타이머
  Timer? searchTimer;

  void resetState() {
    searchKeyword = '';
    recentSearchKeywords = <String>[];
    relatedKeywords = <String>[];
    searchTimer?.cancel();
    notifyListeners();
  }

  /// 검색한 키워드([keyword])를 최근 검색어([recentSearchKeywords])에 저장하고
  /// 검색결과 페이지로 라우팅한다.
  void routeSearchPage(String keyword) {
    searchKeyword = keyword;

    if (searchKeyword.isEmpty) return;

    recentSearchKeywords.insert(0, searchKeyword);
    locator<GlobalKey<NavigatorState>>()
        .currentState
        ?.pushNamed(AppRoutes.productList);
    notifyListeners();
  }

  /// [keyword]로 연관 검색어를 불러와 [relatedKeywords]에 저장한다.
  void setRelatedKeywords(String keyword) {
    searchKeyword = keyword;

    if (searchKeyword.isEmpty) {
      searchTimer?.cancel();
      relatedKeywords.clear();
      notifyListeners();
      return;
    }

    // 과도한 API 요청을 방지하기 위해
    // 1초 이내에 다시 API를 요청하면 기존 타이머 삭제 후 타이머를 다시 시작한다.
    if (searchTimer != null) {
      searchTimer!.cancel();
    }

    searchTimer = Timer(const Duration(seconds: 1), () {
      searchRepository.getRelatedKeyword(searchKeyword).then(
        (List<String> titleList) {
          relatedKeywords = titleList;
          notifyListeners();
        },
      );
    });
  }

  /// 연관검색어([relatedKeywords])를 비운다.
  void clearRelatedKeywords() {
    if (relatedKeywords.isEmpty) return;

    relatedKeywords.clear();
    notifyListeners();
  }
}
