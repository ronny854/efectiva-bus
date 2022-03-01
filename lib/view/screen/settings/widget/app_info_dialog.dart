import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';

class AppInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated('app_info', context), style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).colorScheme.secondary,
                        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1))],
                      ),
                      child: Icon(Icons.clear, size: 18, color: ColorResources.getYellow(context))),
                ),
              ],
            ),
            Divider(thickness: .1, color: ColorResources.COLOR_PRIMARY),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated('VERSION_NAME', context), style: robotoRegular),
                Text('1.0.0', style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ],
            ),
            Divider(thickness: .1, color: ColorResources.COLOR_PRIMARY),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getTranslated('RELEASE_DATE', context), style: robotoRegular),
                Text('1 Noviembre 2021', style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
