import 'dart:async';

import 'package:activa_efectiva_bus/api/endpoints.dart';
import 'package:activa_efectiva_bus/api/http_client.dart';
import 'package:activa_efectiva_bus/data/model/body/login_model.dart';
import 'package:activa_efectiva_bus/data/model/response/login_model.dart';
import 'package:flutter/cupertino.dart';

abstract class IApiAuth {
  Future<LoginResponse> login(LoginModel payload);
}

class ApiAuth implements IApiAuth {
  final HttpClient http;

  ApiAuth({@required this.http});

  // Validate partner authentication and retrieve data for app
  Future<LoginResponse> login(LoginModel payload) async {
    try {
      final res = await http.post(Endpoints.login,
          body: {"email": payload.email, "password": payload.password});

      return LoginResponse.fromJson(res["data"]);
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
