import 'package:http/http.dart';

abstract class HttpClient {
  Future<Response> get(String url, {Map<String, String>? headers});

  Future<Response> post(String url, {Map<String, String>? headers, dynamic body});
}
