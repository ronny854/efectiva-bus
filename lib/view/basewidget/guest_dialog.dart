import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/screen/auth/auth_screen.dart';

class GuestDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(clipBehavior: Clip.none, fit: StackFit.loose, children: [
        Positioned(
          left: 0,
          right: 0,
          top: -50,
          child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 52,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  Images.no_conex,
                ),
              )),
        ),
        Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(getTranslated('WARNING', context),
                  style: robotoBold.copyWith(
                      fontSize: Dimensions.FONT_SIZE_LARGE)),
              SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.PADDING_SIZE_SMALL,
                    right: Dimensions.PADDING_SIZE_SMALL),
                child: Text(getTranslated('WARNING_SKIP_SETUP', context),
                    textAlign: TextAlign.justify, style: robotoRegular),
              ),
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              Divider(height: 0, color: Theme.of(context).hintColor),
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
                    child: Text(getTranslated('CANCEL', context),
                        style: robotoBold.copyWith(
                            color: Theme.of(context).primaryColor)),
                  ),
                )),
                Expanded(
                    child: InkWell(
                  onTap: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => AuthScreen()),
                      (route) => false),
                  child: Container(
                    padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(10))),
                    child: Text(getTranslated('ok', context),
                        style: robotoBold.copyWith(color: Colors.white)),
                  ),
                )),
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}
