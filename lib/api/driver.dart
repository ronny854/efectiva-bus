import 'dart:async';

import 'package:activa_efectiva_bus/api/endpoints.dart';
import 'package:activa_efectiva_bus/api/exceptions/network_exceptions.dart';
import 'package:activa_efectiva_bus/api/http_client.dart';
import 'package:activa_efectiva_bus/data/model/response/driver_model.dart';
import 'package:flutter/cupertino.dart';

abstract class IApiDriver {
  Future<DriverModel> getDriverInformation(
      String busId, String operatorId, String pin);
}

class ApiDriver implements IApiDriver {
  final HttpClient http;

  ApiDriver({@required this.http});

  // Get driver information if authentication is valid for current operator & transport unit
  Future<DriverModel> getDriverInformation(
      String busId, String operatorId, String pin) async {
    try {
      final res = await http.get(Endpoints.authDriver +
          "/" +
          busId +
          "/" +
          operatorId +
          "/" +
          pin);
      return DriverModel.fromJson(res["data"]);
    } catch (e) {
      print("####### ApiDriver ERROR #######");
      if (e is NetworkException) {
        print(e.message);
      }
      print("##############################");
      throw e;
    }
  }
}
