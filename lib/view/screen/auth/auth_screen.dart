import 'package:activa_efectiva_bus/provider/device_provider.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/auth_provider.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/screen/auth/widget/sign_in_partner_widget.dart';
import 'package:activa_efectiva_bus/view/screen/auth/widget/sign_in_driver_widget.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  PageController _pageController = PageController(initialPage: 0);
  int page = 0;

  @override
  Widget build(BuildContext context) {
    // SignInDriver will be only available if  partner has already logged into and if mac address exists
    var partnerHasLogged =
        Provider.of<AuthProvider>(context, listen: false).getPartnerHasLogged();
    var bluetoothConnectionDone =
        Provider.of<DeviceProvider>(context, listen: false)
            .getSelectedMacAddress();

    List<Widget> availableSignInWidgets =
        partnerHasLogged && bluetoothConnectionDone != ""
            ? [
                SignInPartnerWidget(),
                SignInDriverWidget(),
              ]
            : [
                SignInPartnerWidget(),
              ];

    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // background
          Provider.of<ThemeProvider>(context).darkTheme
              ? SizedBox()
              : Image.asset(Images.background,
                  fit: BoxFit.fill,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width),

          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 30),

                // for logo with text
                Image.asset(Images.logo_with_name_image,
                    height: 150,
                    width: 200,
                    color: ColorResources.getPrimary(context)),
                Text(getTranslated('AUTHORIZATION', context),
                    style: robotoBold.copyWith(
                        fontSize: Dimensions.FONT_SIZE_LARGE)),
                Padding(
                  padding: EdgeInsets.all(Dimensions.MARGIN_SIZE_LARGE),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        bottom: 0,
                        right: Dimensions.MARGIN_SIZE_EXTRA_SMALL,
                        left: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: ColorResources.getGainsBoro(context),
                        ),
                      ),
                      Consumer<AuthProvider>(
                        builder: (context, authProvider, child) => Row(
                          children: [
                            InkWell(
                              onTap: () => _pageController.animateToPage(0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeIn),
                              child: Column(
                                children: [
                                  Text(
                                      getTranslated('SIGN_IN_PARTNER', context),
                                      style: page == 0
                                          ? robotoBold
                                          : robotoRegular),
                                  Container(
                                    height: 1,
                                    width: 40,
                                    margin: EdgeInsets.only(top: 8),
                                    color: page == 0
                                        ? Theme.of(context).primaryColor
                                        : Colors.transparent,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 25),
                            partnerHasLogged
                                ? InkWell(
                                    onTap: () => _pageController.animateToPage(
                                        1,
                                        duration: Duration(milliseconds: 500),
                                        curve: Curves.easeIn),
                                    child: Column(
                                      children: [
                                        Text(
                                            getTranslated(
                                                'SIGN_IN_DRIVER', context),
                                            style: page == 1
                                                ? robotoBold
                                                : robotoRegular),
                                        Container(
                                            height: 1,
                                            width: 50,
                                            margin: EdgeInsets.only(top: 8),
                                            color: page == 1
                                                ? Theme.of(context).primaryColor
                                                : Colors.transparent),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: PageView(
                      controller: _pageController,
                      pageSnapping: true,
                      onPageChanged: (index) {
                        setState(() {
                          page = index;
                        });
                      },
                      children: availableSignInWidgets),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
