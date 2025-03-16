import 'package:http/http.dart';
import 'package:http/retry.dart';

import 'htttp_client_service.dart';

class RetryHttpClient implements HttpClient {
  final RetryClient _client;

  RetryHttpClient(Client baseClient) : _client = RetryClient(baseClient);

  @override
  Future<Response> get(String url, {Map<String, String>? headers}) {
    return _client.get(Uri.parse(url), headers: headers);
  }

  @override
  Future<Response> post(String url, {Map<String, String>? headers, dynamic body}) {
    return _client.post(Uri.parse(url), headers: headers, body: body);
  }
}
