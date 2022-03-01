import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/card_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:activa_efectiva_bus/view/screen/stats/widget/loan_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class StatsScreen extends StatefulWidget {
  final bool isBackButtonExist;
  StatsScreen({this.isBackButtonExist = true});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final partner = Provider.of<PartnerProvider>(context, listen: false)
        .selectedPartnerInformation;
    if (partner != null) {
      print(partner.bus.id);
      EasyLoading.show(status: getTranslated('PLEASE_WAIT', context));
      Provider.of<CardProvider>(context, listen: false)
          .getStats(partner.bus.id, "", "", "day")
          .then((value) {
        EasyLoading.dismiss();
      }).catchError((Object error) {
        Utils.showErrorMessage(context, error);
      });
    }

    return Scaffold(
      backgroundColor: ColorResources.getIconBg(context),
      body:
          // AppBar
          Stack(children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5)),
          child: Image.asset(
            Images.toolbar_background,
            fit: BoxFit.fill,
            height: 50 + MediaQuery.of(context).padding.top,
            width: double.infinity,
            color: Provider.of<ThemeProvider>(context).darkTheme
                ? Colors.black
                : null,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          height: 50,
          alignment: Alignment.center,
          child: Row(children: [
            SizedBox(width: Dimensions.PADDING_SIZE_DEFAULT),
            Text(
              getTranslated('stats', context),
              style: robotoRegular.copyWith(fontSize: 20, color: Colors.white),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ]),
        ),
        SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 25 + MediaQuery.of(context).padding.top,
              ),
              Expanded(
                child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 450,
                            margin: EdgeInsets.fromLTRB(15, 15, 15, 10),
                            decoration: BoxDecoration(
                              color: ColorResources.WHITE,
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 10),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal:
                                          Dimensions.PADDING_SIZE_DEFAULT),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      IconTitleButton(
                                        icon: Icons.today,
                                        title: "Hoy",
                                        frecuency: "day",
                                      ),
                                      IconTitleButton(
                                        icon: Icons.calendar_view_week,
                                        title: "Semana",
                                        frecuency: "week",
                                      ),
                                      IconTitleButton(
                                          icon: Icons.calendar_view_month,
                                          title: "Mes",
                                          frecuency: "month"),
                                      // IconTitleButton(
                                      //     icon: Icons.filter_alt_outlined,
                                      //     title: "Filtrar"),
                                    ],
                                  ),
                                ),
                                Consumer<CardProvider>(
                                    builder: (context, card, child) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 87, right: 87, top: 23),
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: 130,
                                          height: 130,
                                          alignment: Alignment.center,
                                          child: CircleAvatar(
                                            backgroundColor:
                                                ColorResources.COLOR_SHAMROCK,
                                            radius: 100,
                                            child: Container(
                                              width: double.infinity,
                                              height: double.infinity,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    card.stats.total.toString(),
                                                    style:
                                                        robotoRegular.copyWith(
                                                            fontSize: 30,
                                                            color:
                                                                ColorResources
                                                                    .WHITE),
                                                  ),
                                                  Text(
                                                    "USD",
                                                    style:
                                                        robotoRegular.copyWith(
                                                            fontSize: Dimensions
                                                                .FONT_SIZE_SMALL,
                                                            color:
                                                                ColorResources
                                                                    .WHITE),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                                SizedBox(height: 15),
                                Consumer<CardProvider>(
                                    builder: (context, card, child) {
                                  return LoanCardWidget(card.stats);
                                }),
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: EdgeInsets.symmetric(
                          //       horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                          //   child: Text("Últimas transacciones",
                          //       style: robotoBold.copyWith(
                          //           color: ColorResources.COLOR_CHARCOAL)),
                          // ),
                          // SizedBox(height: 5),
                          // ListView.builder(
                          //   itemCount: 10,
                          //   physics: NeverScrollableScrollPhysics(),
                          //   shrinkWrap: true,
                          //   itemBuilder: (context, index) => Card(
                          //     child: ListTile(
                          //       leading: Icon(
                          //         Icons.account_circle_outlined,
                          //         size: 32,
                          //       ),
                          //       title: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: [
                          //           Text(
                          //             "Steven Eduardo Tabango Clavijo",
                          //             style: robotoBold.copyWith(
                          //                 fontSize: Dimensions.FONT_SIZE_SMALL,
                          //                 color: ColorResources.COLOR_DIM_GRAY),
                          //           ),
                          //           Text(
                          //             "45D2BA21",
                          //             style: robotoBold.copyWith(
                          //                 fontSize: Dimensions.FONT_SIZE_SMALL,
                          //                 color: ColorResources.COLOR_DIM_GRAY),
                          //           ),
                          //         ],
                          //       ),
                          //       trailing: Text(
                          //         '0.30 USD',
                          //         style: TextStyle(fontSize: 20),
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ])),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

class LoanModel {
  String title, totalUsd, upcomingPaymentUsd, date;

  LoanModel({this.title, this.totalUsd, this.upcomingPaymentUsd, this.date});
}

class LoanData {
  static List<LoanModel> getAllLoanData = [
    LoanModel(
      title: "Car Loan",
      totalUsd: 'USD \$4100.00',
      upcomingPaymentUsd: 'USD \$658.00',
      date: 'Due on 12/12/2020',
    )
  ];
}

class IconTitleButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String frecuency;
  IconTitleButton({@required this.icon, @required this.title, this.frecuency});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            final partner = Provider.of<PartnerProvider>(context, listen: false)
                .selectedPartnerInformation;
            if (partner != null) {
              EasyLoading.show(status: getTranslated('PLEASE_WAIT', context));
              Provider.of<CardProvider>(context, listen: false)
                  .getStats(partner.bus.id, "", "", frecuency)
                  .then((value) {
                EasyLoading.dismiss();
              }).catchError((Object error) {
                Utils.showErrorMessage(context, error);
              });
            }
          },
          child: Icon(icon, color: Colors.white),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(10),
            primary: Colors.blue, // <-- Button color
            onPrimary: Colors.red, // <-- Splash color
          ),
        ),
        SizedBox(height: 7),
        Text(title,
            style: robotoRegular.copyWith(
                color: ColorResources.COLOR_DIM_GRAY,
                fontSize: Dimensions.FONT_SIZE_SMALL)),
      ],
    );
  }
}
