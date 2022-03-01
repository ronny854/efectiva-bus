
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:flutter/material.dart';
 

class InsuranceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.WHITE.withOpacity(.95),
      appBar: AppBar(
        title: Text(
          "Strings.INSURANCE",
          style: robotoBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            color: ColorResources.COLOR_GRAY,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: ColorResources.COLOR_GRAY,
              size: 20,
            ),
            tooltip: 'Add Insurance',
            onPressed: () {},
          )
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 370,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: ColorResources.WHITE,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(bottom: 115),
                  child: Image.asset(
                    'assets/Illustration/insurance.png',
                    width: 140,
                    height: 140,
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 40, right: 40, bottom: 20),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            width: 61,
                            height: 25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: ColorResources.COLOR_GAINS),
                            child: Text(
                              "Strings.LIFE",
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 61,
                                height: 25,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: ColorResources.COLOR_GAINS),
                                child: Text(
                                  "Strings.VEHICLE",
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 61,
                                height: 25,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: ColorResources.COLOR_GAINS),
                                child: Text(
                                  "Strings.HEALTH",
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 65,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: 61,
                                height: 25,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: ColorResources.COLOR_GAINS),
                                child: Text(
                                  "Strings.OTHER",
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 61,
                                height: 25,
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: ColorResources.COLOR_DARK_ORCHID),
                                child: Text(
                                  "Strings.HOME",
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                    color: ColorResources.WHITE,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            alignment: Alignment.center,
                            width: 61,
                            height: 25,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: ColorResources.COLOR_GAINS),
                            child: Text(
                              "Strings.DISABILITY",
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: RichText(
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                  text: "Strings.YOU_ARE_CURRENTLY",
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                  ),
                                ),
                                TextSpan(
                                  text: "Strings.UNDER_INSURED",
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                    color: ColorResources.COLOR_PRIMARY_DARK,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: ColorResources.COLOR_VERY_LIGHT_GRAY,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 30, top: 13, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Strings.INSURANCE",
                                style: robotoBold,
                              ),
                              Text(
                                "Strings.LOREM__CONSECTETUR1",
                                style: robotoRegular.copyWith(
                                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 22,
                            height: 22,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ColorResources.COLOR_SHAMROCK,
                                style: BorderStyle.solid,
                                width: 2.0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Icon(
                              Icons.done,
                              size: 15,
                              color: ColorResources.COLOR_SHAMROCK,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 192,
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 30, top: 18, right: 30, bottom: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Strings.BUY_INSURANCE",
                    style: robotoBold,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/transport.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.HOME",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/health 2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.HEALTH",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/transport 2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.VAHICLE",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/education2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.EDUCATION",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: ColorResources.COLOR_DARK_ORCHID,
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 310,
            decoration: BoxDecoration(
              color: ColorResources.WHITE,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 30, top: 18, right: 30, bottom: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Strings.MY_INSURANCE",
                    style: robotoBold,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/transport.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.HOME",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/health 2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.HEALTH",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/transport 2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.VAHICLE",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/education2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.EDUCATION",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Strings.UPCOMING",
                    style: robotoBold,
                  ),
                  Text(
                    "Strings.DUE_DATE",
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/transport.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.HOME",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/health 2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.HEALTH",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/transport 2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.VAHICLE",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Image.asset(
                              'assets/Icon/education2.png',
                              width: 52,
                              height: 52,
                              fit: BoxFit.scaleDown,
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "Strings.EDUCATION",
                              style: robotoRegular.copyWith(fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
