import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:testvalley/config/api_config.dart';
import 'package:testvalley/data/model/product/product_model.dart';

class SearchApi {
  final String urlPath = '/v1/search/shop.json';

  Future<ProductModelResponse?> getSearchList(
    Map<String, dynamic> query,
  ) async {
    final Uri uri = Uri.https(naverApiUrl, urlPath, query);

    try {
      final http.Response response = await httpClient.get(uri, headers: {
        'X-Naver-Client-Id': naverClientId,
        'X-Naver-Client-Secret': naverClientSecret,
      });

      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        log('$body');
        final ProductModelResponse productModelResponse =
            ProductModelResponse.fromJson(body);

        return productModelResponse;
      }
      log('${response.statusCode}');
    } catch (e, s) {
      log('error : $e | $s');
    }

    return null;
  }
}
