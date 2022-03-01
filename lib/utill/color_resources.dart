import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class ColorResources {
  static Color getBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF007ca3)
        : Color(0xFF00ADE3);
  }

  static Color getColombiaBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF678cb5)
        : Color(0xFF92C6FF);
  }

  static Color getLightSkyBlue(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFFc7c7c7)
        : Color(0xFF8DBFF6);
  }

  static Color getHarlequin(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF257800)
        : Color(0xFF3FCC01);
  }

  static Color getCheris(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF941546)
        : Color(0xFFE2206B);
  }

  static Color getGrey(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF808080)
        : Color(0xFFF1F1F1);
  }

  static Color getRed(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF7a1c1c)
        : Color(0xFFD32F2F);
  }

  static Color getYellow(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF916129)
        : Color(0xFFFFAA47);
  }

  static Color getHint(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFFc7c7c7)
        : Color(0xFF9E9E9E);
  }

  static Color getGainsBoro(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF999999)
        : Color(0xFFE6E6E6);
  }

  static Color getTextBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF414345)
        : Color(0xFFF3F9FF);
  }

  static Color getTextBgInverted(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFFF3F9FF)
        : Color(0xFF414345);
  }

  static Color getIconBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF2e2e2e)
        : Color(0xFFF9F9F9);
  }

  static Color getHomeBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF3d3d3d)
        : Color(0xFFF0F0F0);
  }

  static Color getImageBg(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF3f4347)
        : Color(0xFFE2F0FF);
  }

  static Color getSellerTxt(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF517091)
        : Color(0xFF92C6FF);
  }

  static Color getChatIcon(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFFebebeb)
        : Color(0xFFD4D4D4);
  }

  static Color getLowGreen(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF7d8085)
        : Color(0xFFEFF6FE);
  }

  static Color getGreen(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF167d3c)
        : Color(0xFF23CB60);
  }

  static Color getFloatingBtn(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF49698c)
        : Color(0xFF7DB6F5);
  }

  static Color getPrimary(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFFf0f0f0)
        : Color(0xFF1B7FED);
  }

  static Color getPrimaryInversed(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF49698c)
        : Color(0xFFf0f0f0);
  }

  static Color getPrimaryButton(BuildContext context) {
    return Provider.of<ThemeProvider>(context).darkTheme
        ? Color(0xFF49698c)
        : Color(0xff1B7FED);
  }

  static const Color COLOR_SPECIALIST_CARD_PRICE = Color(0xffFDBD83);
  static const Color COLOR_HOME_BACKGROUND = Color(0xffF6F6F6);
  static const Color SOFT_BLUE = Color(0xff2FA9DE);
  static const Color COLOR_GOOGLE = Color(0xffF0F7FF);
  static const Color BLACK = Color(0xff000000);
  static const Color WHITE = Color(0xffFFFFFF);
  static const Color COLOR_PRIMARY = Color(0xff1B7FED);
  static const Color COLOR_BLUE = Color(0xff00ADE3);
  static const Color COLUMBIA_BLUE = Color(0xff92C6FF);
  static const Color LIGHT_SKY_BLUE = Color(0xff8DBFF6);
  static const Color HARLEQUIN = Color(0xff3FCC01);
  static const Color CERISE = Color(0xffE2206B);
  static const Color GREY = Color(0xffF1F1F1);
  static const Color RED = Color(0xFFD32F2F);
  static const Color YELLOW = Color(0xFFFFAA47);
  static const Color HINT_TEXT_COLOR = Color(0xff9E9E9E);
  static const Color GAINS_BORO = Color(0xffE6E6E6);
  static const Color TEXT_BG = Color(0xffF3F9FF);
  static const Color ICON_BG = Color(0xffF9F9F9);
  static const Color HOME_BG = Color(0xffF0F0F0);
  static const Color IMAGE_BG = Color(0xffE2F0FF);
  static const Color SELLER_TXT = Color(0xff92C6FF);
  static const Color CHAT_ICON_COLOR = Color(0xffD4D4D4);
  static const Color LOW_GREEN = Color(0xffEFF6FE);
  static const Color GREEN = Color(0xff23CB60);
  static const Color FLOATING_BTN = Color(0xff7DB6F5);
  static const Color COLOR_SHAMROCK = Color(0xff4AD4A3);
  static const Color COLOR_VERY_LIGHT_GRAY = Color(0xffCFCFCF);
  static const Color COLOR_CHARCOAL = Color(0xff474747);
  static const Color COLOR_DIM_GRAY = Color(0xff6D6D6D);
  static const Color COLOR_GRAY = Color(0xff707070);
  static const Color COLOR_ROYAL_BLUE = Color(0xff4D49E1);
  static const Color COLOR_PRIMARY_DARK = Color(0xff4D49E1);
  static const Color COLOR_GAINS = Color(0xffE6E5FF);
  static const Color COLOR_DARK_ORCHID = Color(0xffA42AC3);
  static const Color COLOR_BACKGROUND = Color(0xffF7F6FB);
  static const Color COLOR_WHITE_SMOKE = Color(0xffF5F5F5);
  static const Color COLOR_MEDIUM_VIOLET_RED = Color(0xffE41397);
  static const Color COLOR_LIGHT_BLACK = Color(0xff1E2841);
  static const Color COLOR_Lavender = Color(0xffF5F8FD);
  static const Color COLOR_WILD_WATERMELON = Color(0xffFF6580);
  static const Color COLOR_ALIZARIN = Color(0xffF22C2C);
  static const Color COLOR_CARIBBEAN_GREEN = Color(0xff04D49E);
  static const Color COLOR_YELLOW = Color(0xFFF3C89C);
  static const Color COLOR_NEON_CARROT = Color(0xffFF913A);

  static const Map<int, Color> colorMap = {
    50: Color(0x10192D6B),
    100: Color(0x20192D6B),
    200: Color(0x30192D6B),
    300: Color(0x40192D6B),
    400: Color(0x50192D6B),
    500: Color(0x60192D6B),
    600: Color(0x70192D6B),
    700: Color(0x80192D6B),
    800: Color(0x90192D6B),
    900: Color(0xff192D6B),
  };

  static const MaterialColor PRIMARY_MATERIAL =
      MaterialColor(0xFF192D6B, colorMap);
}
