import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:provider/provider.dart';

class CustomExpandedAppBar extends StatelessWidget {
  final String title;
  final Widget child;
  final bool canGoBack;
  CustomExpandedAppBar(
      {@required this.title, @required this.child, this.canGoBack = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        // Background
        Image.asset(
          Images.more_page_header,
          height: 150,
          fit: BoxFit.fill,
          width: MediaQuery.of(context).size.width,
          color: Provider.of<ThemeProvider>(context).darkTheme
              ? Colors.black
              : null,
        ),

        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Row(children: [
            canGoBack
                ? CupertinoNavigationBarBackButton(
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context))
                : SizedBox(
                    height: 0,
                    width: 0,
                  ),
            Text(title,
                style:
                    robotoRegular.copyWith(fontSize: 20, color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ]),
        ),

        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getHomeBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: child,
        ),
      ]),
    );
  }
}
