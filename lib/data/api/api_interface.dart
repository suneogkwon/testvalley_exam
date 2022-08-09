import 'package:http/http.dart';

abstract class ApiInterface {
  final Client httpClient = Client();

  /// [uri] 경로로 get 호출
  Future<Response> callGet({
    required Uri uri,
    Map<String, String>? header,
  });

  /// [uri] 경로로 post 호출
  Future<Response> callPost({
    required Uri uri,
    Map<String, String>? header,
    Object? body,
  });
}
