import 'package:http/http.dart';
import 'package:testvalley/data/api/api_interface.dart';
import 'package:testvalley/data/api/api_response.dart';

abstract class NaverApiInterface extends ApiInterface {
  /// API 호출 도메인
  final String url = 'openapi.naver.com';
  final String _clientId = 'oBLnuHCdv1az_W4FTcrD';
  final String _clientSecret = 'xQrHkkcJbU';
}

abstract class INaverSearchApi extends NaverApiInterface {
  /// API 호출 경로
  final String path = '/v1/search/shop.json';

  @override
  Future<Response> callGet({required Uri uri, Map<String, String>? header}) {
    final Map<String, String> _commonHeader = {
      'X-Naver-Client-Id': _clientId,
      'X-Naver-Client-Secret': _clientSecret,
    };

    if (header != null) _commonHeader.addAll(header);

    return httpClient.get(
      uri,
      headers: _commonHeader,
    );
  }

  @override
  Future<Response> callPost({
    required Uri uri,
    Map<String, String>? header,
    Object? body,
  }) {
    final Map<String, String> _commonHeader = {
      'X-Naver-Client-Id': _clientId,
      'X-Naver-Client-Secret': _clientSecret,
    };

    if (header != null) _commonHeader.addAll(header);

    return httpClient.post(
      uri,
      headers: _commonHeader,
      body: body,
    );
  }

  Future<ApiResponse> getShoppingSearchResult({
    Map<String, dynamic>? query,
  });
}
