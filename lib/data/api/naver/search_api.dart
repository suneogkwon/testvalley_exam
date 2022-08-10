import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:testvalley/data/api/api_response.dart';
import 'package:testvalley/data/api/naver_api_interface.dart';

class NaverSearchApi extends INaverSearchApi {
  @override
  Future<ApiResponse> getShoppingSearchResult({
    Map<String, dynamic>? query,
  }) async {
    final Map<String, String>? castedQuery = query?.map(
      (key, value) => MapEntry(
        key,
        value.toString(),
      ),
    );

    final Uri uri = Uri.https(url, path, castedQuery);

    try {
      final http.Response response = await callGet(uri: uri);

      if (response.statusCode == 200) {
        return ApiResponse(
          statusCode: 200,
          data: jsonDecode(response.body),
        );
      }
      return ApiResponse(
        statusCode: response.statusCode,
      );
    } catch (e) {
      return ApiResponse();
    }
  }
}
