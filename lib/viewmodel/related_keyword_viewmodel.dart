import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testvalley/data/repository/search_repository.dart';

class RelatedKeywordViewModel extends ChangeNotifier {
  final SearchRepository searchRepository = SearchRepository();

  /// 연관 검색어 리스트
  List<String> relatedKeywords = <String>[];

  // API 요청 딜레이 타이머
  Timer? _searchApiTimer;

  @override
  void dispose() {
    _searchApiTimer?.cancel();
    super.dispose();
  }

  void resetState() {
    _searchApiTimer?.cancel();
    relatedKeywords.clear();
    notifyListeners();
  }

  /// [keyword]로 연관 검색어를 불러와 [relatedKeywords]에 저장한다.
  void setRelatedKeywords(String keyword) {
    if (keyword.isEmpty) {
      resetState();
      return;
    }

    // 과도한 API 요청을 방지하기 위해
    // 0.5초 이내에 다시 요청하면 요청 딜레이를 초기화한다.
    _searchApiTimer?.cancel();

    _searchApiTimer = Timer(
      const Duration(milliseconds: 500),
      () async {
        final List<String> titleList =
            await searchRepository.getRelatedKeyword(keyword);
        relatedKeywords = titleList;
        notifyListeners();
      },
    );
  }
}
