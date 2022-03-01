import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';

class NoInternetOrDataScreen extends StatelessWidget {
  final bool isNoInternet;
  final Widget child;
  NoInternetOrDataScreen({@required this.isNoInternet, this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(isNoInternet ? Images.no_internet : Images.no_data, width: 150, height: 150),
              Text(isNoInternet ? getTranslated('OPPS', context) : getTranslated('sorry', context), style: robotoBold.copyWith(
                fontSize: 30,
                color: isNoInternet ? Theme.of(context).textTheme.bodyText1.color : ColorResources.getColombiaBlue(context),
              )),
              SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              Text(
                isNoInternet ? 'No hay conexión a internet' : 'No hay registros',
                textAlign: TextAlign.center,
                style: robotoRegular,
              ),
              SizedBox(height: 40),
              isNoInternet ? Container(
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: ColorResources.getYellow(context)),
                child: TextButton(
                  onPressed: () async {
                    if(await Connectivity().checkConnectivity() != ConnectivityResult.none) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => child));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Text(getTranslated('RETRY', context), style: robotoBold.copyWith(color: Theme.of(context).colorScheme.secondary, fontSize: Dimensions.FONT_SIZE_LARGE)),
                  ),
                ),
              ) : SizedBox.shrink(),

            ],
          ),
        ),
      ),
    );
  }
}
