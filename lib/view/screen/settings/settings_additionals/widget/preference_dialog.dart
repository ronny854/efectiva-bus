import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';

class PreferenceDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.all(Dimensions.PADDING_SIZE_DEFAULT),
          child: Text(getTranslated('preference', context), style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
        ),
        SwitchTile(title: 'Rutas de transporte', value: true),
        SwitchTile(title: 'Unidades de transporte', value: true),
        SwitchTile(title: 'Transacciones', value: true),
        Divider(height: Dimensions.PADDING_SIZE_EXTRA_SMALL, color: ColorResources.HINT_TEXT_COLOR),
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(getTranslated('CANCEL', context), style: robotoRegular.copyWith(color: ColorResources.YELLOW)),
          ),
        ),
      ]),
    );
  }
}

class SwitchTile extends StatelessWidget {
  final String title;
  final bool value;
  SwitchTile({@required this.title, @required this.value});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      trailing: CupertinoSwitch(
        value: value,
        activeColor: ColorResources.GREEN,
        trackColor: ColorResources.RED,
        onChanged: (isChecked) {},
      ),
      onTap: () {},
    );
  }
}

