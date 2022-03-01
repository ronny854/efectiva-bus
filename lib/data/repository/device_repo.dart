import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DeviceRepo {
  final SharedPreferences sharedPreferences;

  DeviceRepo({@required this.sharedPreferences});

  Future<void> saveSelectedMacAddress(String macAddress) async {
    try {
      await sharedPreferences.setString(AppConstants.CURRENT_MAC_ADDRESS, macAddress);
    } catch (e) {
      throw e;
    }
  }

  String getSelectedMacAddress() {
    return sharedPreferences.getString(AppConstants.CURRENT_MAC_ADDRESS) ?? "";
  }

  Future<bool> clearSelectedMacAddress() async {
    await sharedPreferences.remove(AppConstants.CURRENT_MAC_ADDRESS);
    return true;
  }
}
