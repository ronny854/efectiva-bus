import 'package:activa_efectiva_bus/api/auth.dart';
import 'package:activa_efectiva_bus/data/model/body/login_model.dart';
import 'package:activa_efectiva_bus/data/model/response/login_model.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final SharedPreferences sharedPreferences;
  final ApiAuth api;
  AuthRepo({@required this.sharedPreferences, this.api});

  // for  user token
  Future<LoginResponse> login(LoginModel payload) async {
    try {
      return this.api.login(payload);
    } catch (e) {
      throw e;
    }
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstants.TOKEN) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstants.TOKEN);
  }

  Future<bool> clearSharedData() async {
    await sharedPreferences.remove(AppConstants.CURRENCY);
    await sharedPreferences.remove(AppConstants.TOKEN);
    await sharedPreferences.remove(AppConstants.CURRENT_DRIVER);
    return true;
  }

  // for  Remember Email
  Future<void> saveUserEmailAndPassword(String email) async {
    try {
      await sharedPreferences.setString(AppConstants.USER_EMAIL, email);
    } catch (e) {
      throw e;
    }
  }

  Future<void> savePartnerHasLogged() async {
    try {
      await sharedPreferences.setBool(AppConstants.PARTNER_HAS_LOGGED, true);
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveToken(String token) async {
    try {
      await sharedPreferences.setString(AppConstants.TOKEN, token);
    } catch (e) {
      throw e;
    }
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstants.USER_EMAIL) ?? "";
  }

  bool getPartnerHasLogged() {
    return sharedPreferences.getBool(AppConstants.PARTNER_HAS_LOGGED) ?? false;
  }

  Future<bool> clearUserEmailAndToken() async {
    await sharedPreferences.remove(AppConstants.TOKEN);
    return await sharedPreferences.remove(AppConstants.USER_EMAIL);
  }
}
