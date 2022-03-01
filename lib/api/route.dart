import 'dart:async';

import 'package:activa_efectiva_bus/api/endpoints.dart';
import 'package:activa_efectiva_bus/api/exceptions/network_exceptions.dart';
import 'package:activa_efectiva_bus/api/http_client.dart';
import 'package:activa_efectiva_bus/data/model/response/route_model.dart';
import 'package:flutter/material.dart';

abstract class IApiRoute {
  Future<List<RouteModel>> getOperatorRoutes(String operatorId);
}

class ApiRoute implements IApiRoute {
  final HttpClient http;

  ApiRoute({@required this.http});

  Future<List<RouteModel>> getOperatorRoutes(String operatorId) async {
    try {
      final res =
          await http.get(Endpoints.getOperatorRoutes + "/" + operatorId);
      return List<RouteModel>.from(
          res["data"].map((i) => RouteModel.fromJson(i)));
    } catch (e) {
      print("####### ApiRoute ERROR #######");
      print((e as NetworkException).message);
      print("##############################");
      throw e;
    }
  }
}
