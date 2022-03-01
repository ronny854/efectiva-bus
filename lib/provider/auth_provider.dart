import 'package:activa_efectiva_bus/data/enums/roles.dart';
import 'package:activa_efectiva_bus/data/model/response/login_model.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/data/model/body/login_model.dart';
import 'package:activa_efectiva_bus/data/model/body/register_model.dart';
import 'package:activa_efectiva_bus/data/repository/auth_repo.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({@required this.authRepo});

  UserRole _role = UserRole.NONE;
  UserRole get role => _role;

  Future<LoginResponse> login(LoginModel payload) async {
    try {
      final data = await authRepo.login(payload);
      authRepo.saveUserEmailAndPassword(data.userData.email);
      authRepo.savePartnerHasLogged();
      authRepo.saveToken(data.token);
      return data;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  String setCurrentUserRole(UserRole role) {
    _role = role;
    notifyListeners();
  }

  // for user Section
  String getUserToken() {
    return authRepo.getUserToken();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> clearSharedData() async {
    return await authRepo.clearSharedData();
  }

  String getUserEmail() {
    return authRepo.getUserEmail() ?? "";
  }

  bool getPartnerHasLogged() {
    return authRepo.getPartnerHasLogged() ?? false;
  }

  Future<bool> clearUserEmailAndToken() async {
    return authRepo.clearUserEmailAndToken();
  }
}
