import 'package:activa_efectiva_bus/provider/profile_provider.dart';
import 'package:activa_efectiva_bus/view/basewidget/animated_custom_dialog.dart';
import 'package:activa_efectiva_bus/view/screen/dashboard/dashboard_screen.dart';
import 'package:activa_efectiva_bus/view/screen/setup/widget/omit_config_dialog.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/basewidget/title_row.dart';
import '../../basewidget/transport_units_list.dart';
import 'dart:ui';

import 'package:provider/provider.dart';

class SetupScreen extends StatelessWidget {
  final ScrollController _scrollController = ScrollController();
  final String greet;
  final String instruction;
  final String buttonText;
  final bool showWarning;
  SetupScreen(
      {@required this.greet,
      @required this.instruction,
      @required this.showWarning,
      @required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getHomeBg(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            SliverAppBar(
              floating: true,
              elevation: 0,
              centerTitle: false,
              automaticallyImplyLeading: false,
              pinned: true,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              title: Image.asset(Images.logo_with_name_image,
                  height: 50, color: ColorResources.getPrimary(context)),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL,
                        20, Dimensions.PADDING_SIZE_SMALL, 0),
                    child: Row(children: [
                      Text(greet,
                          style: robotoBold.copyWith(
                              color: ColorResources.getPrimary(context),
                              fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                      SizedBox(
                        width: 5,
                      ),
                      Consumer<ProfileProvider>(
                          builder: (context, profile, child) {
                        return Text(
                            profile.userData != null
                                ? profile.userData.displayName
                                : "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: robotoBold.copyWith(
                                color: ColorResources.getFloatingBtn(context),
                                fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE));
                      }),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(Dimensions.PADDING_SIZE_SMALL,
                        20, Dimensions.PADDING_SIZE_SMALL, 0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(instruction,
                              textAlign: TextAlign.justify,
                              style: robotoBold.copyWith(
                                  color:
                                      ColorResources.getTextBgInverted(context),
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE)),
                        ]),
                  ),
                  // List of transport units
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimensions.PADDING_SIZE_SMALL,
                        20,
                        Dimensions.PADDING_SIZE_SMALL,
                        Dimensions.PADDING_SIZE_SMALL),
                    child: TitleRow(
                        title: getTranslated('MY_TRANSPORTS', context)),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.PADDING_SIZE_SMALL),
                    child: TransportUnitsList(
                        checkConnection: true,
                        redirectScreen: "setup",
                        scrollController: _scrollController),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: ListTile(
                      title: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            primary: ColorResources.getPrimaryButton(context)),
                        icon: Icon(
                          Icons.queue_play_next_outlined,
                          color: Colors.white,
                        ),
                        label: Text(buttonText),
                        onPressed: () {
                          if (!showWarning) {
                            Navigator.of(context).pushAndRemoveUntil(
                                PageRouteBuilder(
                                  transitionDuration:
                                      Duration(milliseconds: 500),
                                  pageBuilder: (context, animation,
                                          secondaryAnimation) =>
                                      DashBoardScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    animation = CurvedAnimation(
                                        parent: animation,
                                        curve: Curves.easeOutQuad);
                                    return ScaleTransition(
                                        scale: animation,
                                        child: child,
                                        alignment: Alignment.center);
                                  },
                                ),
                                (route) => false);
                            return;
                          }
                          showAnimatedDialog(context, OmitConfigurationDialog(),
                              isFlip: true);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
