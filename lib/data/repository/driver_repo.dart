import 'package:activa_efectiva_bus/api/driver.dart';
import 'package:activa_efectiva_bus/data/model/response/driver_model.dart';
import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class DriverRepo {
  final ApiDriver api;
  final SharedPreferences sharedPreferences;

  DriverRepo({@required this.api, @required this.sharedPreferences});

  // Get data for driver existing and authorized in the current bus or operator
  Future<DriverModel> getDriverInformation(
      String busID, String operatorID, String pin) async {
    try {
      return this.api.getDriverInformation(busID, operatorID, pin);
    } catch (e) {
      throw e;
    }
  }

  // The currently driver of the travel
  Future<void> saveSelectedDriver(DriverModel d) async {
    try {
      await sharedPreferences.setString(
          AppConstants.CURRENT_DRIVER, jsonEncode(d));
    } catch (e) {
      throw e;
    }
  }

  DriverModel getCurrentDriver() {
    String d = sharedPreferences.getString(AppConstants.CURRENT_DRIVER);

    if (d != null && d != "") {
      return DriverModel.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.CURRENT_DRIVER)));
    }

    return null;
  }

  Future<bool> cleanSelectedTransportUnit() async {
    await sharedPreferences.remove(AppConstants.CURRENT_DRIVER);
    return true;
  }
}
