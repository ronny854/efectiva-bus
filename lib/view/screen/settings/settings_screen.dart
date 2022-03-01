import 'package:activa_efectiva_bus/data/enums/roles.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/provider/driver_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/profile_provider.dart';
import 'package:activa_efectiva_bus/view/screen/profile/profile_screen.dart';
import 'package:activa_efectiva_bus/view/screen/settings/settings_additionals/widget/preference_dialog.dart';
import 'package:activa_efectiva_bus/view/screen/settings/settings_additionals/settings_additionals_screen.dart';
import 'package:activa_efectiva_bus/view/screen/settings/widget/app_info_dialog.dart';
import 'package:activa_efectiva_bus/view/screen/settings/widget/sign_out_confirmation_dialog.dart';
import 'package:activa_efectiva_bus/view/screen/setup/setup_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/basewidget/animated_custom_dialog.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/web_view_screen.dart';
import 'package:activa_efectiva_bus/view/screen/settings/notification/notification_screen.dart';
import 'package:activa_efectiva_bus/view/screen/settings/support/support_ticket_screen.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
    NetworkInfo.checkConnectivity(context);

    return Scaffold(
      body: Stack(children: [
        // Background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(
            Images.more_page_header,
            height: 150,
            fit: BoxFit.fill,
            color: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.black
                : null,
          ),
        ),

        // AppBar
        Positioned(
          top: 40,
          left: Dimensions.PADDING_SIZE_SMALL,
          right: Dimensions.PADDING_SIZE_SMALL,
          child: Consumer<AuthProvider>(
            builder: (context, auth, child) {
              if (auth.role == UserRole.DRIVER) {
                return buildDriverUserInfo();
              }

              return buildPartnerUserInfo();
            },
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 120),
          decoration: BoxDecoration(
            color: ColorResources.getIconBg(context),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(children: [
              SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
              TitleButton(
                  icon: Icons.bluetooth_drive_sharp,
                  title: getTranslated('device_prox', context),
                  navigateTo: SetupScreen(
                    greet: getTranslated('HELLO', context),
                    instruction: getTranslated(
                        'SELECT_TRANSPORT_INSTRUCTION_B', context),
                    buttonText: getTranslated('CANCEL', context),
                    showWarning: false,
                  )),
              TitleButton(
                  newScreen: false,
                  icon: Icons.sync,
                  title: getTranslated('SYNC_OPTION', context),
                  navigateTo: PreferenceDialog()),
              TitleButton(
                  icon: Icons.notifications_active_outlined,
                  title: getTranslated('notification', context),
                  navigateTo: NotificationScreen()),
              //TitleButton(image: Images.chats, title: getTranslated('chats', context), navigateTo: InboxScreen()),
              TitleButton(
                  icon: Icons.support_agent_outlined,
                  title: getTranslated('support_ticket', context),
                  navigateTo: SupportTicketScreen()),

              TitleButton(
                  icon: Icons.forum_outlined,
                  title: getTranslated('faq', context),
                  navigateTo: WebViewScreen(
                    title: getTranslated('faq', context),
                    url: 'https://www.google.com',
                  )),
              TitleButton(
                  icon: Icons.more_horiz_outlined,
                  title: getTranslated('settings_additionals', context),
                  navigateTo: SettingsAdditionalsScreen()),
              TitleButton(
                  icon: Icons.book_online_outlined,
                  title: getTranslated('terms_condition', context),
                  navigateTo: WebViewScreen(
                    title: getTranslated('terms_condition', context),
                    url: 'https://www.google.com',
                  )),
              ListTile(
                leading: Icon(Icons.verified_sharp,
                    size: 32, color: ColorResources.getPrimary(context)),
                title: Text(getTranslated('app_info', context),
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE)),
                onTap: () =>
                    showAnimatedDialog(context, AppInfoDialog(), isFlip: true),
              ),

              ListTile(
                leading: Icon(Icons.exit_to_app,
                    color: ColorResources.getPrimary(context), size: 25),
                title: Text(getTranslated('sign_out', context),
                    style: robotoRegular.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE)),
                onTap: () => showAnimatedDialog(
                    context, SignOutConfirmationDialog(),
                    isFlip: true),
              ),
            ]),
          ),
        ),
      ]),
    );
  }

  Widget buildDriverUserInfo() {
    return Consumer<DriverProvider>(
      builder: (context, driver, child) {
        return Row(children: [
          Image.asset(Images.logo_with_name_image,
              height: 50, color: ColorResources.WHITE),
          Expanded(child: SizedBox.shrink()),
          Text(driver.driverInformation.names,
              style: robotoRegular.copyWith(color: ColorResources.WHITE)),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                driver.driverInformation.photoUrl,
                width: 35,
                height: 35,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ]);
      },
    );
  }

  Widget buildPartnerUserInfo() {
    return Consumer<ProfileProvider>(
      builder: (context, profile, child) {
        return Row(children: [
          Image.asset(Images.logo_with_name_image,
              height: 50, color: ColorResources.WHITE),
          Expanded(child: SizedBox.shrink()),
          Text(profile.userData.displayName,
              style: robotoRegular.copyWith(color: ColorResources.WHITE)),
          SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                profile.userData.photoURL,
                width: 35,
                height: 35,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ]);
      },
    );
  }
}

class TitleButton extends StatelessWidget {
  final String title;
  final Widget navigateTo;
  final IconData icon;
  final bool newScreen;
  TitleButton({this.title, this.icon, this.navigateTo, this.newScreen = true});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 32, color: ColorResources.getPrimary(context)),
      title: Text(title,
          style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
      onTap: () => newScreen
          ? Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => navigateTo),
            )
          : showDialog(
              context: context,
              builder: (BuildContext context) {
                return navigateTo;
              }),
    );
  }
}
