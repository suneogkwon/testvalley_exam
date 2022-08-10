import 'package:flutter/material.dart';
import 'package:testvalley/config/storage_util.dart';

class RecentKeywordViewModel extends ChangeNotifier {
  RecentKeywordViewModel() {
    keywordList = Pref().storage.getStringList(Pref.recentKeyword) ?? [];
  }

  List<String> keywordList = [];

  /// 최근 검색어 리스트를 비운다.
  void deleteAll() {
    keywordList.clear();
    _saveRecentKeywordList();
    notifyListeners();
  }

  /// 최근 검색어 리스트에서 [index]번째 요소를 삭제한다.
  void deleteSelected(int index) {
    keywordList.removeAt(index);
    _saveRecentKeywordList();
    notifyListeners();
  }

  /// [keyword]를 최근 검색어 리스트에 추가한다.
  void addKeyword(String keyword) {
    if (keyword.isEmpty) return;

    final int keywordIndex = keywordList.indexOf(keyword);

    // 리스트에 이미 존재하는 키워드라면 첫번째로 이동
    if (keywordIndex != -1) {
      deleteSelected(keywordIndex);
    }
    keywordList.insert(0, keyword);
    _saveRecentKeywordList();
  }

  /// 최근검색어([recentKeywordList])를 내부 저장소에 저장한다.
  void _saveRecentKeywordList() {
    Pref().storage.setStringList(
          Pref.recentKeyword,
          keywordList,
        );
  }
}
