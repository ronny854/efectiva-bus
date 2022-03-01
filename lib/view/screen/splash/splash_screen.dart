import 'package:activa_efectiva_bus/data/enums/connection_status.dart';
import 'package:activa_efectiva_bus/provider/device_provider.dart';
import 'package:activa_efectiva_bus/provider/driver_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/profile_provider.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/view/screen/auth/auth_screen.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/provider/splash_provider.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/screen/dashboard/dashboard_screen.dart';
import 'package:activa_efectiva_bus/view/screen/splash/widget/splash_painter.dart';
import 'package:provider/provider.dart';
import 'package:loading_gifs/loading_gifs.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<SplashProvider>(context, listen: false).initSharedPrefData();
    Provider.of<SplashProvider>(context, listen: false)
        .initConfig()
        .then((bool isSuccess) {
      Provider.of<RouteProvider>(context, listen: false)
          .getAllOperatorRoutesHive();
      Provider.of<DeviceProvider>(context, listen: false)
          .setConnectionStatus(DeviceStatus.UNAVAILABLE);
      Provider.of<PartnerProvider>(context, listen: false)
          .setSelectedPartnerInformation();
      Provider.of<RouteProvider>(context, listen: false).setSelectedRoute();
      Provider.of<DriverProvider>(context, listen: false).getCurrentDriver();
      Provider.of<ProfileProvider>(context, listen: false).getPartnerProfile();
      if (Provider.of<AuthProvider>(context, listen: false).getUserToken() !=
          "") {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => DashBoardScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => AuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.black
                : ColorResources.COLOR_PRIMARY,
            child: CustomPaint(
              painter: SplashPainter(),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(Images.splash_logo,
                    height: 250.0, fit: BoxFit.scaleDown, width: 250.0),
                Image.asset(cupertinoActivityIndicator, scale: 5)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
