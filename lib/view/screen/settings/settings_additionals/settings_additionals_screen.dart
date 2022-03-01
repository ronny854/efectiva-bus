import 'package:activa_efectiva_bus/view/basewidget/custom_app_bar.dart';
import 'package:activa_efectiva_bus/view/screen/settings/settings_additionals/widget/currency_dialog.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/splash_provider.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/basewidget/animated_custom_dialog.dart';
import 'package:provider/provider.dart';

class SettingsAdditionalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return WillPopScope(
      onWillPop: () {
        Provider.of<SplashProvider>(context, listen: false)
            .setFromSetting(false);
        return Future.value(true);
      },
      child: Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        body: Column(
          children: [
            CustomAppBar(
                title: getTranslated('settings_additionals', context),
                isBackButtonExist: true),
            Expanded(
              child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SwitchListTile(
                        value: Provider.of<ThemeProvider>(context).darkTheme,
                        onChanged: (bool isActive) =>
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme(),
                        title: Text(getTranslated('dark_theme', context),
                            style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_LARGE)),
                      ),
                      Divider(),
                      TitleButton(
                        icon: Icons.language,
                        title: getTranslated('choose_language', context),
                        onTap: () => showAnimatedDialog(
                            context, CurrencyDialog(isCurrency: false)),
                      ),

                      // TitleButton(
                      //   icon: Icons.language,
                      //   title: "Strings.preference",
                      //   onTap: () => showAnimatedDialog(context, PreferenceDialog()),
                      // ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class TitleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  TitleButton({this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 32, color: ColorResources.getPrimary(context)),
      title: Text(title,
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: onTap,
    );
  }
}
