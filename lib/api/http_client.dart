import 'dart:async';
import 'dart:convert';

import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'exceptions/network_exceptions.dart';

class HttpClient {
  final JsonDecoder _decoder = JsonDecoder();
  final SharedPreferences sharedPreferences;
  HttpClient({@required this.sharedPreferences});

  Future<dynamic> get(String url) {
    return http.get(Uri.parse(url), headers: {
      "Authorization": sharedPreferences.getString(AppConstants.TOKEN)
    }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        var rs = _decoder.convert(res);

        throw NetworkException(message: rs["msg"], statusCode: statusCode);
      }

      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body, encoding}) {
    return http
        .post(Uri.parse(url),
            body: jsonEncode(body),
            headers: {
              "Authorization": sharedPreferences.getString(AppConstants.TOKEN),
              'Content-Type': 'application/json; charset=UTF-8',
            },
            encoding: encoding)
        .then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 400 || json == null) {
        var rs = _decoder.convert(res);
        throw NetworkException(message: rs["msg"], statusCode: statusCode);
      }
      return _decoder.convert(res);
    });
  }
}
