import 'package:activa_efectiva_bus/data/model/response/login_model.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/data/repository/profile_repo.dart';

class ProfileProvider extends ChangeNotifier {
  final ProfileRepo profileRepo;
  ProfileProvider({@required this.profileRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserData _userData;
  UserData get userData => _userData;

  Future<bool> savePartnerProfile(UserData data) async {
    try {
      await profileRepo.savePartnerProfile(data);

      _userData = data;
      notifyListeners();
      return true;
    } catch (e) {
      throw e;
    }
  }

  void getPartnerProfile() {
    final profile = profileRepo.getPartnerProfile();
    _userData = profile;
    notifyListeners();
  }
}
