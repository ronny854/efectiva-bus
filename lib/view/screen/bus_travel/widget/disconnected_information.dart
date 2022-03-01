import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/web_view_screen.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/widget/square_button.dart';
import 'package:activa_efectiva_bus/view/screen/settings/support/support_ticket_screen.dart';
import 'package:activa_efectiva_bus/view/screen/setup/setup_screen.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';

class DisconnectedInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 110),
      decoration: BoxDecoration(
        color: ColorResources.getIconBg(context),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(children: [
          Container(
            padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
            margin: EdgeInsets.only(
              top: Dimensions.MARGIN_SIZE_DEFAULT,
              bottom: Dimensions.MARGIN_SIZE_DEFAULT,
              left: Dimensions.MARGIN_SIZE_DEFAULT,
              right: Dimensions.MARGIN_SIZE_DEFAULT,
            ),
            decoration: BoxDecoration(
              color: ColorResources.getRed(context),
              borderRadius: BorderRadius.circular(10),
              border:
                  Border.all(color: ColorResources.getRed(context), width: 2),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    getTranslated('SERVICE_NOT_AVAILABLE', context),
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        color: ColorResources.WHITE),
                  ),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.warning, color: ColorResources.WHITE, size: 24),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                        child: Text(
                      getTranslated('NO_ACTIVE_CONNECTION', context),
                      textAlign: TextAlign.justify,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: ColorResources.WHITE),
                    )),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.bluetooth_drive_sharp,
                        color: ColorResources.WHITE, size: 24),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                        child: Text(
                      getTranslated('MAKE_CONNECTION_INSTRUCTION', context),
                      textAlign: TextAlign.justify,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: ColorResources.WHITE),
                    )),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.help_outline,
                        color: ColorResources.WHITE, size: 24),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                        child: Text(
                      getTranslated('FAQS_INSTRUCTION', context),
                      textAlign: TextAlign.justify,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: ColorResources.WHITE),
                    )),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Icon(Icons.support_agent_outlined,
                        color: ColorResources.WHITE, size: 24),
                    SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
                    Expanded(
                        child: Text(
                      getTranslated('SUPPORT_INSTRUCTION', context),
                      textAlign: TextAlign.justify,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_LARGE,
                          color: ColorResources.WHITE),
                    )),
                  ]),
                ]),
          ),
          Divider(thickness: 2),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          buildOptionsWhenDisconnected(context),
          SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
          Divider(thickness: 2),
          SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT),
        ]),
      ),
    );
  }

  Widget buildOptionsWhenDisconnected(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SquareButton(
          icon: Icons.bluetooth_drive_sharp,
          title: getTranslated('CONNECTION_OPTION', context),
          navigateTo: SetupScreen(
            greet: getTranslated('HELLO', context),
            instruction:
                getTranslated('SELECT_TRANSPORT_INSTRUCTION_B', context),
            buttonText: getTranslated('CANCEL', context),
            showWarning: false,
          )),
      SquareButton(
          icon: Icons.help_outline,
          title: getTranslated('HELP_OPTION', context),
          navigateTo: WebViewScreen(
            title: getTranslated('faq', context),
            url: 'https://www.google.com',
          )),
      SquareButton(
          icon: Icons.support_agent_outlined,
          title: getTranslated('SUPPORT_OPTION', context),
          navigateTo: SupportTicketScreen()),
    ]);
  }
}
