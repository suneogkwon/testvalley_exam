import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:testvalley/config/api_config.dart';

class SearchApi {
  final String naverApiUrl = 'openapi.naver.com';
  final String urlPath = '/v1/search/shop.json';

  Future<Map<String, dynamic>> getSearchList(
    Map<String, dynamic> query,
  ) async {
    final Uri uri = Uri.https(naverApiUrl, urlPath, query);
    log('uri: $uri');

    final http.Response response = await httpClient.get(uri, headers: {
      'X-Naver-Client-Id': naverClientId,
      'X-Naver-Client-Secret': naverClientSecret,
    });

    try {
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
      log('${response.statusCode}');
      return {};
    } catch (e) {
      log('error : $e');
      return {};
    }
  }
}
