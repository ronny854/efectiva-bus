import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_app_bar.dart';
import 'package:activa_efectiva_bus/view/screen/stats/stats_screen.dart';
import 'package:activa_efectiva_bus/view/screen/stats/widget/loan_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class TransportInformationScreen extends StatefulWidget {
  @override
  _TransportInformationScreenState createState() => _TransportInformationScreenState();
}

class _TransportInformationScreenState extends State<TransportInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CustomAppBar(title: "Unidad de transporte"),
            Expanded(
              child: ListView(physics: BouncingScrollPhysics(), children: [
                Container(
                  width: double.infinity,
                  height: 350,

                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconTitleButton(icon: Icons.today, title: "Hoy"),
                            IconTitleButton(
                                icon: Icons.calendar_view_week,
                                title: "Semana"),
                            IconTitleButton(
                                icon: Icons.calendar_view_month, title: "Mes"),
                            // IconTitleButton(
                            //     icon: Icons.filter_alt_outlined,
                            //     title: "Filtrar"),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 87, right: 87, top: 23),
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              width: 130,
                              height: 130,
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                backgroundColor: ColorResources.COLOR_SHAMROCK,
                                radius: 100,
                                child: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "100.36",
                                        style: robotoRegular.copyWith(
                                            fontSize: 30,
                                            color: ColorResources.WHITE),
                                      ),
                                      Text(
                                        "USD",
                                        style: robotoRegular.copyWith(
                                            fontSize:
                                            Dimensions.FONT_SIZE_SMALL,
                                            color: ColorResources.WHITE),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 15),
                      //LoanCardWidget(LoanData.getAllLoanData[0]),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: ColorResources.COLOR_BACKGROUND,
                ),
                Container(
                  height: 140,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 11, top: 13, right: 11),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Información de la unidad de transporte",
                              style: robotoBold,
                            ),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                Icon(Icons.domain),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        "COOPERATIVA DE AHORRO Y CREDITO PILAHUIN TIO 24 DE MAYO",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: robotoRegular,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(Icons.directions_bus),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "ICN-049",
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: robotoRegular,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ), // for 3rd card

                Container(
                  width: double.infinity,
                  height: 10,
                  color: ColorResources.COLOR_BACKGROUND,
                ), // for background
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    color: ColorResources.WHITE,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 11, top: 13, right: 11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Conductores",
                                  style: robotoBold,
                                ),
                                Text(
                                  "Cualquier conductor de la operadora puede conducir esta unidad.",
                                  style: robotoRegular.copyWith(
                                    fontSize: 11,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),

              ]),
            ), // for background
          ],
        ),
      ),
    );
  }
}
