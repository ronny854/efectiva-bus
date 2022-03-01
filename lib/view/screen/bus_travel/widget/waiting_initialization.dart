import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WaitingInitialization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      margin: EdgeInsets.only(top: 110),
      decoration: BoxDecoration(
        color: ColorResources.getIconBg(context),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: Column(children: [
        SpinKitRipple(color: ColorResources.COLOR_PRIMARY),
        Text(
          getTranslated('PLEASE_WAIT', context),
          style: robotoBold.copyWith(
              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
              color: ColorResources.getPrimary(context)),
        ),
      ]),
    );
  }


}
