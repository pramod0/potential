import 'dart:convert';

import 'package:http/http.dart';

genResponse(error, code) => Response(jsonEncode({"error": error}), code);

parseResponse(response) {
  return response.runtimeType is Response ? response.body : {"error": response.toString()};
}
