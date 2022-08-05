import 'dart:developer';

import 'package:testvalley/data/api/search_api.dart';

class SearchRepository {
  SearchRepository({required this.searchApi});

  final SearchApi searchApi;

  Future<List<String>> getRelatedKeyword(String keyword) async {
    final Map<String, dynamic> data = await searchApi.getSearchList({
      'query': keyword,
    });

    final List<dynamic> items = data['items'] ?? [];
    final List<String> titleList = <String>[];

    for (Map<String, dynamic> item in items) {
      if (item['title'] != null) {
        titleList.add(item['title']);
      }
    }
    log('titleList : $titleList');

    return titleList;
  }
}
