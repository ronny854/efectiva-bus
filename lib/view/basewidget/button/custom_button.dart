import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:provider/provider.dart';

class CustomButton extends StatelessWidget {
  final Function onTap;
  final String buttonText;
  CustomButton({this.onTap, @required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: EdgeInsets.all(0),
      ),
      child: Container(
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: ColorResources.getChatIcon(context),
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.2), spreadRadius: 1, blurRadius: 7, offset: Offset(0, 1)), // changes position of shadow
            ],
            gradient: Provider.of<ThemeProvider>(context).darkTheme ? null : LinearGradient(colors: [
              Theme.of(context).primaryColor,
              ColorResources.getBlue(context),
              ColorResources.getBlue(context),
            ]),
            borderRadius: BorderRadius.circular(10)),
        child: Text(buttonText,
            style: robotoBold.copyWith(
              fontSize: 16,
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
    );
  }
}
