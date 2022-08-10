import 'dart:async';

import 'package:flutter/material.dart';
import 'package:testvalley/config/service_locator.dart';
import 'package:testvalley/data/repository/naver_repository_interface.dart';

class RelatedKeywordViewModel extends ChangeNotifier {
  final INaverSearchRepo _searchRepo = locator<INaverSearchRepo>();

  /// 연관 검색어 리스트
  List<String> relatedKeywords = <String>[];

  // API 요청 딜레이 타이머
  Timer? _searchApiTimer;

  void resetState() {
    _searchApiTimer?.cancel();
    relatedKeywords.clear();
    notifyListeners();
  }

  /// [keyword]로 연관 검색어를 불러와 [relatedKeywords]에 저장한다.
  void setRelatedKeywordList(String keyword) {
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
            await _searchRepo.getSearchTitleList(keyword) ?? [];
        relatedKeywords = titleList;
        notifyListeners();
      },
    );
  }
}
