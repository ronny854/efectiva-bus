import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/data/model/response/route_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/provider/localization_provider.dart';
import 'package:activa_efectiva_bus/provider/notification_provider.dart';
import 'package:activa_efectiva_bus/provider/profile_provider.dart';
import 'package:activa_efectiva_bus/provider/splash_provider.dart';
import 'package:activa_efectiva_bus/provider/support_ticket_provider.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/provider/device_provider.dart';
import 'package:activa_efectiva_bus/provider/driver_provider.dart';
import 'package:activa_efectiva_bus/provider/travel_provider.dart';
import 'package:activa_efectiva_bus/provider/card_provider.dart';

import 'package:activa_efectiva_bus/theme/dark_theme.dart';
import 'package:activa_efectiva_bus/theme/light_theme.dart';
import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:activa_efectiva_bus/view/screen/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'di_container.dart' as di;
import 'localization/app_localization.dart';
import 'provider/banner_provider.dart';

void configLoading() {
  EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..indicatorType = EasyLoadingIndicatorType.foldingCube
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..boxShadow = const []
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configLoading();
  // HIVE DATABASE
  await Hive.initFlutter();
  Hive.registerAdapter(PartnerInformationResponseAdapter());
  Hive.registerAdapter(BusAdapter());
  Hive.registerAdapter(OperatorAdapter());
  Hive.registerAdapter(RatesAdapter());
  Hive.registerAdapter(DriversAdapter());
  Hive.registerAdapter(DeviceAdapter());
  Hive.registerAdapter(RouteModelAdapter());

  await Hive.openBox<PartnerInformationResponse>('partner_information');
  await Hive.openBox<RouteModel>('routes');

  // DEPENDENCY INJECTION
  await di.init();
  // PROVIDER
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<BannerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PartnerProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<RouteProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DeviceProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DriverProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<TravelProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CardProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<SupportTicketProvider>()),
      ChangeNotifierProvider(
          create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    AppConstants.languages.forEach((language) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    });
    return MaterialApp(
      title: 'Activa Efectiva',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? dark : light,
      locale: Provider.of<LocalizationProvider>(context).locale,
      localizationsDelegates: [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      home: ResponsiveSizer(builder: (context, orientation, screenType) {
        return SplashScreen();
      }),
      builder: EasyLoading.init(),
    );
  }
}
