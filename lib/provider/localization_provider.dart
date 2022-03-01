import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LocalizationProvider({@required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = Locale('es', 'EC');
  bool _isLtr = true;
  int _languageIndex;

  Locale get locale => _locale;
  bool get isLtr => _isLtr;
  int get languageIndex => _languageIndex;

  void setLanguage(Locale locale) {
    if(locale.languageCode == 'es'){
      _locale = Locale('es', 'EC');
      _isLtr = true;
    }else {
      _locale = Locale('en', 'US');
      _isLtr = true;
    }
    AppConstants.languages.forEach((language) {
      if(language.languageCode == _locale.languageCode) {
        _languageIndex = AppConstants.languages.indexOf(language);
      }
    });

    _saveLanguage(_locale);
    notifyListeners();
  }

  _loadCurrentLanguage() async {
    _locale = Locale(sharedPreferences.getString(AppConstants.LANGUAGE_CODE) ?? 'es',
        sharedPreferences.getString(AppConstants.COUNTRY_CODE) ?? 'EC');
    _isLtr = true;
    AppConstants.languages.forEach((language) {
      if(language.languageCode == _locale.languageCode) {
        _languageIndex = AppConstants.languages.indexOf(language);
      }
    });
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstants.LANGUAGE_CODE, locale.languageCode);
    sharedPreferences.setString(AppConstants.COUNTRY_CODE, locale.countryCode);
  }
}