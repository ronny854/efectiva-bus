import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_expanded_app_bar.dart';
import 'package:activa_efectiva_bus/view/screen/settings/support/add_ticket_screen.dart';

class IssueTypeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<String> issueTypeList = [
      getTranslated('select_your_category', context),
      getTranslated('select_your_category', context),
      getTranslated('select_your_category', context)
    ];
    NetworkInfo.checkConnectivity(context);

    return CustomExpandedAppBar(
      title: getTranslated('support_ticket', context),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(
              top: Dimensions.PADDING_SIZE_LARGE,
              left: Dimensions.PADDING_SIZE_LARGE),
          child: Text(getTranslated('add_new_ticket', context),
              style: robotoBold.copyWith(fontSize: 20)),
        ),
        Padding(
          padding: EdgeInsets.only(
              left: Dimensions.PADDING_SIZE_LARGE,
              bottom: Dimensions.PADDING_SIZE_LARGE),
          child: Text(getTranslated('select_your_category', context),
              style: robotoRegular),
        ),
        Expanded(
            child: ListView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE,
              vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          itemCount: issueTypeList.length,
          itemBuilder: (context, index) {
            return Container(
              color: ColorResources.getLowGreen(context),
              margin: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_SMALL),
              child: ListTile(
                leading: Icon(Icons.query_builder,
                    color: ColorResources.getPrimary(context)),
                title: Text(issueTypeList[index], style: robotoBold),
                onTap: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              AddTicketScreen(type: issueTypeList[index])));
                },
              ),
            );
          },
        )),
      ]),
    );
  }
}
