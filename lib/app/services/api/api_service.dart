import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/retry.dart';

import '../../utils/constants/urls.dart';
import '../../utils/helpers/responseHelp.dart';

class ApiService {
  ApiService._privateConstructor();

  static final ApiService _instance = ApiService._privateConstructor();

  factory ApiService() => _instance;

  final RetryClient _client = RetryClient(Client(), retries: 2);

  Future<Response> _performRequest(
    Future<Response> Function() request, {
    Duration timeout = const Duration(seconds: 10),
  }) async {
    try {
      Response response = await request().timeout(timeout);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return response;
      }
      return genResponse('Unexpected Error: ${response.body} ${response.reasonPhrase}', response.statusCode);
    } on TimeoutException {
      return genResponse('Request timed out. Please try again later.', 500);
    } on ClientException {
      return genResponse('Connection error. Please check your internet.', 500);
    } catch (e) {
      return genResponse('An error occurred: ${e.toString()}', 500);
    }
  }

  Future<String> postRequest(String url, Map<String, String> headers, Map<String, dynamic> body) async {
    Response response = await _performRequest(() => post(Uri.parse(url), headers: headers, body: jsonEncode(body)));
    return response.body;
  }

  Future<String> getRequest(String url, Map<String, String> headers) async {
    Response response = await _performRequest(() => get(Uri.parse(url), headers: headers));
    return response.body;
  }

  Future<String> retryPostRequest(String url, Map<String, String> headers, Map<String, dynamic> body) async {
    Response response =
        await _performRequest(() => _client.post(Uri.parse(url), headers: headers, body: jsonEncode(body)));
    return response.body;
  }

  Future<String> retryGetRequest(String url, Map<String, String> headers) async {
    Response response = await _performRequest(() => _client.get(Uri.parse(url), headers: headers));
    return response.body;
  }
}

class UserApi {
  UserApi._privateConstructor();

  static final UserApi _instance = UserApi._privateConstructor();

  factory UserApi() => _instance;

  Future<String> signUp(String payload) async {
    String url = '${URL.domainURL}${URL.signupURL}';
    return ApiService().postRequest(url, {'Content-Type': 'application/json; charset=UTF-8'}, jsonDecode(payload));
  }

  Future<String> processLogin(String userName, String password) async {
    String url = '${URL.domainURL}${URL.loginURL}';
    return ApiService().retryPostRequest(url, {
      'Content-Type': 'application/json; charset=UTF-8'
    }, {
      'email': userName,
      'password': password,
      'deviceType': 'android',
    });
  }

  Future<String> sendOTP(String email) async {
    return ApiService().postRequest(
      '${URL.domainURL}${URL.sendOTP}',
      {'Content-Type': 'application/json; charset=UTF-8'},
      {'email': email},
    );
  }

  Future<String> reSendOTP(String email) async {
    return ApiService().postRequest(
      '${URL.domainURL}${URL.resendOTP}',
      {'Content-Type': 'application/json; charset=UTF-8'},
      {'email': email},
    );
  }
}

class DashboardApi {
  DashboardApi._privateConstructor();

  static final DashboardApi _instance = DashboardApi._privateConstructor();

  factory DashboardApi() => _instance;

  Future<String> dashboard(String token, int limit, int offset) async {
    String url = '${URL.domainURL}${URL.dashboardURL}?limit=$limit&offset=$offset';
    return ApiService().getRequest(url, {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  Future<String> schemeSummary(String token, String fund, String scheme) async {
    return ApiService().getRequest('${URL.domainURL}${URL.schemeSummaryURL}?fund=$fund&scheme=$scheme', {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }
}

class AccountApi {
  AccountApi._privateConstructor();

  static final AccountApi _instance = AccountApi._privateConstructor();

  factory AccountApi() => _instance;

  Future<String> logout(String token) async {
    return ApiService().getRequest('${URL.domainURL}${URL.logout}', {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  Future<String> removeUser(String token) async {
    return ApiService().getRequest('${URL.domainURL}${URL.removeUser}', {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }
}
