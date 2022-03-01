class Endpoints {
  Endpoints._();

  // base url
  static const String BASE_URL = "https://zbango-dev.xyz/api/v1";

  // receiveTimeout
  static const int receiveTimeout = 5000;

  // connectTimeout
  static const int connectionTimeout = 5000;

  // Endpoints
  static const String login = BASE_URL + "/auth";
  static const String getPartnerInformation = BASE_URL + "/app/partner-information";
  static const String getOperatorRoutes = BASE_URL + "/app/operator-routes";
  static const String authDriver = BASE_URL + "/app/driver";

  static const String getCardByCode = BASE_URL + "/cards/active";
  static const String executeCharge = BASE_URL + "/app/charge";
  static const String getLastCardChargedTransactions = BASE_URL + "/app/card";


  static const String addBalance = BASE_URL + "/cards/active/balance";
  static const String deleteLastTransaction = BASE_URL + "/app/void";

  static const String stats = BASE_URL +"/app/stats";

}