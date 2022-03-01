import 'package:activa_efectiva_bus/data/model/response/login_model.dart';
import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class ProfileRepo {
  final SharedPreferences sharedPreferences;
  ProfileRepo({@required this.sharedPreferences});

  // The currently partner user logged
  Future<void> savePartnerProfile(UserData data) async {
    try {
      await sharedPreferences.setString(
          AppConstants.CURRENT_PROFILE, jsonEncode(data));
    } catch (e) {
      throw e;
    }
  }

  UserData getPartnerProfile() {
    String profile = sharedPreferences.getString(AppConstants.CURRENT_PROFILE);

    if (profile != null && profile != "") {
      return UserData.fromJson(
          jsonDecode(sharedPreferences.getString(AppConstants.CURRENT_PROFILE)));
    }

    return null;
  }

  Future<bool> cleanPartnerProfile() async {
    await sharedPreferences.remove(AppConstants.CURRENT_PROFILE);
    return true;
  }
}
