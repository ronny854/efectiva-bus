import 'package:activa_efectiva_bus/data/repository/language_model.dart';

class AppConstants {
  // db
  static const String DB_NAME = "activa_efectiva.db";
  
  // sharePreference
  static const String TOKEN = 'token';
  static const String USER_EMAIL = 'user_email';
  static const String CURRENCY = 'currency';
  static const String PARTNER_HAS_LOGGED = "partner_has_logged";
  static const String CURRENT_BUS_ID = "current_bus_id";
  static const String CURRENT_OPERATOR_ID = "current_operator_id";
  static const String CURRENT_MAC_ADDRESS = "current_mac_address";
  static const String CURRENT_DRIVER = "current_driver";
  static const String CURRENT_PROFILE = "current_profile";
  static const String CURRENT_ROUTE = "current_route";
  static const String CURRENT_PARTNER_ID = "current_partner_id";

  // order status
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String THEME = 'theme';

  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: '',
        languageName: 'Español',
        countryCode: 'EC',
        languageCode: 'es'),
    LanguageModel(
        imageUrl: '',
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
  ];
}
