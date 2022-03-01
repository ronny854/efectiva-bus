import 'package:activa_efectiva_bus/api/auth.dart';
import 'package:activa_efectiva_bus/api/card.dart';
import 'package:activa_efectiva_bus/api/driver.dart';
import 'package:activa_efectiva_bus/api/http_client.dart';
import 'package:activa_efectiva_bus/api/partner.dart';
import 'package:activa_efectiva_bus/api/route.dart';
import 'package:activa_efectiva_bus/data/repository/card_repo.dart';
import 'package:activa_efectiva_bus/data/repository/device_repo.dart';
import 'package:activa_efectiva_bus/data/repository/driver_repo.dart';
import 'package:activa_efectiva_bus/data/repository/partner_repo.dart';
import 'package:activa_efectiva_bus/data/repository/route_repo.dart';
import 'package:activa_efectiva_bus/provider/card_provider.dart';
import 'package:activa_efectiva_bus/provider/device_provider.dart';
import 'package:activa_efectiva_bus/provider/driver_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/provider/travel_provider.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/provider/banner_provider.dart';
import 'package:activa_efectiva_bus/provider/localization_provider.dart';
import 'package:activa_efectiva_bus/provider/notification_provider.dart';
import 'package:activa_efectiva_bus/provider/profile_provider.dart';
import 'package:activa_efectiva_bus/provider/splash_provider.dart';
import 'package:activa_efectiva_bus/provider/support_ticket_provider.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';

import 'data/repository/auth_repo.dart';
import 'data/repository/banner_repo.dart';
import 'data/repository/notification_repo.dart';
import 'data/repository/profile_repo.dart';
import 'data/repository/splash_repo.dart';
import 'data/repository/support_ticket_repo.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();

  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => HttpClient(sharedPreferences: sl()));

  // API methods
  sl.registerLazySingleton(() => ApiAuth(http: sl.get<HttpClient>()));
  sl.registerLazySingleton(() => ApiPartner(http: sl.get<HttpClient>()));
  sl.registerLazySingleton(() => ApiRoute(http: sl.get<HttpClient>()));
  sl.registerLazySingleton(() => ApiDriver(http: sl.get<HttpClient>()));
  sl.registerLazySingleton(() => ApiCard(http: sl.get<HttpClient>()));

  // Repository
  sl.registerLazySingleton(() => BannerRepo());
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl(), api: sl()));
  sl.registerLazySingleton(() => PartnerRepo(api: sl(),sharedPreferences: sl()));
  sl.registerLazySingleton(() => RouteRepo(api: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => DriverRepo(api: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => CardRepo(api: sl()));
  sl.registerLazySingleton(() => DeviceRepo(sharedPreferences: sl()));

  sl.registerLazySingleton(() => NotificationRepo());
  sl.registerLazySingleton(() => ProfileRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl()));
  sl.registerLazySingleton(() => SupportTicketRepo());

  // Provider
  sl.registerFactory(() => BannerProvider(bannerRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => PartnerProvider(partnerRepo: sl()));
  sl.registerFactory(() => RouteProvider(routeRepo: sl()));
  sl.registerFactory(() => DriverProvider(driverRepo: sl()));
  sl.registerFactory(() => CardProvider(cardRepo: sl()));

  sl.registerFactory(() => DeviceProvider(deviceRepo: sl()));
  sl.registerFactory(() => TravelProvider());

  sl.registerFactory(() => NotificationProvider(notificationRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => SupportTicketProvider(supportTicketRepo: sl()));
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
}
