import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/data/model/response/route_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/screen/auth/auth_screen.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

class SignOutConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: 50),
          child: Text(getTranslated('want_to_sign_out', context),
              style: robotoBold, textAlign: TextAlign.center),
        ),
        Divider(height: 0, color: ColorResources.HINT_TEXT_COLOR),
        Row(children: [
          Expanded(
              child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(10))),
              child: Text(getTranslated('NO', context),
                  style: robotoBold.copyWith(color: ColorResources.getPrimary(context))),
            ),
          )),
          Expanded(
              child: InkWell(
            onTap: () {
              Provider.of<AuthProvider>(context, listen: false)
                  .clearSharedData()
                  .then((condition) async {
                print("STARTING CLOSE SESSION");
                // TODO: Move this logic to another repo for only handle HIVE
                await Hive.deleteBoxFromDisk("routes");
                await Hive.deleteBoxFromDisk("partner_information");
                await Hive.openBox<PartnerInformationResponse>(
                    'partner_information');
                await Hive.openBox<RouteModel>('routes');
                Navigator.pop(context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => AuthScreen()),
                    (route) => false);
              });
            },
            child: Container(
                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorResources.RED,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(10))),
                child: Text(getTranslated('YES', context),
                    style: robotoBold.copyWith(
                        color: ColorResources.WHITE))),
          )),
        ]),
      ]),
    );
  }
}
