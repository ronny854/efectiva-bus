import 'package:activa_efectiva_bus/data/enums/connection_status.dart';
import 'package:activa_efectiva_bus/data/enums/device_action.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/provider/card_provider.dart';
import 'package:activa_efectiva_bus/provider/device_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/travel_provider.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/widget/disconnected_information.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/widget/expanded_list_animation.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/widget/scrollbar.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/widget/square_button.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/widget/travel_information.dart';
import 'package:activa_efectiva_bus/view/screen/bus_travel/widget/waiting_initialization.dart';
import 'package:activa_efectiva_bus/view/screen/card_recharge/card_recharge_screen.dart';
import 'package:activa_efectiva_bus/view/screen/charge_delete/charge_delete.dart';
import 'package:activa_efectiva_bus/view/screen/route/route_selection_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/theme_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/screen/driver_auth/driver_auth_screen.dart';
import 'package:loading_gifs/loading_gifs.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class BusTravelScreen extends StatefulWidget {
  @override
  State<BusTravelScreen> createState() => _BusTravelScreenState();
}

class _BusTravelScreenState extends State<BusTravelScreen> {
  Timer _timer;
  TextEditingController _initialBalance;
  bool isStrechedDropDown = false;
  int groupValue;
  String title = 'Seleccione una tarifa preconfigurada';

  @override
  void initState() {
    super.initState();
    _initialBalance = TextEditingController(
            text: Provider.of<CardProvider>(context, listen: false)
                .amount_to_charge) ??
        "";
    print("gretaaaaaaaaaaaaaaaaa");
  }

  @override
  void dispose() {
    _initialBalance.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
          child: Consumer<PartnerProvider>(
            builder: (context, partnerInfo, child) {
              if (partnerInfo.selectedPartnerInformation == null) {
                return Column(children: [
                  Row(children: [
                    Image.asset(Images.logo_with_name_image,
                        height: 48, color: ColorResources.WHITE),
                    Expanded(child: SizedBox.shrink()),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(children: [
                            Text(
                              "UNIDAD DE TRANSPORTE",
                              style: robotoRegular.copyWith(
                                  fontSize: 15, color: ColorResources.WHITE),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]),
                          Row(children: [
                            Text("NO ASIGNADA",
                                style: robotoRegular.copyWith(
                                    fontSize: 12, color: ColorResources.WHITE)),
                          ]),
                        ]),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    ClipOval(
                      child: Material(
                        color: Colors.transparent, // Button color
                        child: InkWell(
                          onTap: () {},
                          child: SizedBox(
                              width: 35,
                              height: 35,
                              child: Icon(
                                Icons.bus_alert,
                                color: ColorResources.WHITE,
                                size: 30,
                              )),
                        ),
                      ),
                    )
                  ]),
                ]);
              }

              return Column(children: [
                Row(children: [
                  Image.asset(Images.logo_with_name_image,
                      height: 48, color: ColorResources.WHITE),
                  Expanded(child: SizedBox.shrink()),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Row(children: [
                      Text(
                        partnerInfo.selectedPartnerInformation.bus.matricula,
                        style: robotoRegular.copyWith(
                            fontSize: 15, color: ColorResources.WHITE),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ]),
                    Row(children: [
                      Text(
                          Utils.getTransportUnitType(partnerInfo
                              .selectedPartnerInformation.bus.operator),
                          style: robotoRegular.copyWith(
                              fontSize: 12, color: ColorResources.WHITE)),
                    ]),
                  ]),
                  SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  ClipOval(
                    child: Material(
                      color: Colors.transparent, // Button color
                      child: InkWell(
                        onTap: () {},
                        child: SizedBox(
                            width: 35,
                            height: 35,
                            child: Icon(
                              Icons.airport_shuttle_sharp,
                              color: ColorResources.WHITE,
                              size: 35,
                            )),
                      ),
                    ),
                  )
                ]),
              ]);
            },
          ),
        ),
        Consumer<DeviceProvider>(builder: (context, device, child) {
          switch (device.deviceStatus) {
            case DeviceStatus.CONNECTED:
              return buildConnectedInformation(context);
            case DeviceStatus.DISCONNECTED:
              return DisconnectedInformation();
            default:
              return WaitingInitialization();
          }
        }),
      ]),
    );
  }

  Widget buildConnectedInformation(BuildContext context) {
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
          TravelInformation(),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          buildOptionsWhenConnected(),
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          Consumer<PartnerProvider>(builder: (context, partner, child) {
            if (partner.selectedPartnerInformation != null &&
                partner
                    .selectedPartnerInformation.bus.operator.enableManualRate) {
              return buildChargeRates();
            }
            return SizedBox(
              height: 0,
            );
          }),

          // Card information
          Consumer<TravelProvider>(builder: (context, travel, child) {
            if (travel.showCard) {
              print("Displaying card...");
              //poner ubicacion Aqui

              startTimer();
            }

            return Column(
              children: [
                Visibility(
                    visible: travel.showCard,
                    child:
                        Consumer<CardProvider>(builder: (context, card, child) {
                      if (card.successReader) {
                        //resetRatesValues();
                        return Container(
                          margin: EdgeInsets.only(
                            bottom: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                            left: Dimensions.MARGIN_SIZE_DEFAULT,
                            right: Dimensions.MARGIN_SIZE_DEFAULT,
                          ),
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Utils.getCardColor(card.chargeInformation),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 1,
                                    blurRadius: 5)
                              ]),
                          child: Stack(children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                        padding: EdgeInsets.all(
                                            Dimensions.PADDING_SIZE_SMALL),
                                        decoration: BoxDecoration(
                                          color:
                                              ColorResources.getIconBg(context),
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10)),
                                        ),
                                        child: FadeInImage.assetNetwork(
                                          image: card.chargeInformation !=
                                                      null &&
                                                  card.chargeInformation
                                                      .isPreferencial
                                              ? card.chargeInformation
                                                  .metadata["photoUrl"]
                                              : "https://dummyimage.com/300x300/E8E8E8/ffffff.jpg&text=A",
                                          placeholder:
                                              cupertinoActivityIndicator,
                                          fit: BoxFit.cover,
                                          height: 100,
                                        )),
                                  ),
                                  Expanded(
                                    flex: 6,
                                    child: Padding(
                                      padding: EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_DEFAULT),
                                          // Card user names
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.person_pin_outlined,
                                                    color: ColorResources
                                                        .getPrimaryInversed(
                                                            context),
                                                    size: 26),
                                                SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                Expanded(
                                                  child: Text(
                                                    card.chargeInformation !=
                                                                null &&
                                                            card.chargeInformation
                                                                .isPreferencial
                                                        ? card.chargeInformation
                                                                    .metadata[
                                                                "names"] +
                                                            " " +
                                                            card.chargeInformation
                                                                    .metadata[
                                                                "lastNames"]
                                                        : "",
                                                    style: robotoRegular.copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_EXTRA_LARGE,
                                                        color: ColorResources
                                                            .getPrimaryInversed(
                                                                context)),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          // Card code
                                          Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Icon(Icons.qr_code,
                                                    color: ColorResources
                                                        .getPrimaryInversed(
                                                            context),
                                                    size: 26),
                                                SizedBox(
                                                    width: Dimensions
                                                        .PADDING_SIZE_SMALL),
                                                Expanded(
                                                  child: Text(
                                                    Utils.maskCode(card
                                                        .chargeInformation
                                                        .code),
                                                    style: robotoBold.copyWith(
                                                        fontSize: Dimensions
                                                            .FONT_SIZE_EXTRA_LARGE,
                                                        color: ColorResources
                                                            .getPrimaryInversed(
                                                                context)),
                                                  ),
                                                ),
                                              ]),
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_SMALL),
/*                                           Expanded(
                                              child: Text(
                                            card.currentAddress,
                                            style: robotoRegular.copyWith(
                                                fontSize: Dimensions
                                                    .FONT_SIZE_EXTRA_LARGE,
                                                color: ColorResources
                                                    .getPrimaryInversed(
                                                        context)),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          )), */
                                          SizedBox(
                                              height: Dimensions
                                                  .PADDING_SIZE_SMALL),
                                          // Card balance
                                          Row(children: [
                                            Icon(Icons.attach_money,
                                                color: Colors.orange, size: 32),
                                            Expanded(
                                              child: Text(
                                                Utils.getBalanceText(
                                                    card.chargeInformation),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: robotoSuperBold.copyWith(
                                                    color: Colors.orange,
                                                    fontSize: Utils
                                                        .getBalanceTextFontSize(
                                                            card.chargeInformation)),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                width: 150,
                                height: 25,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorResources.getYellow(context),
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10)),
                                ),
                                child: Text(
                                  card.chargeInformation != null &&
                                          card.chargeInformation.isPreferencial
                                      ? card.chargeInformation
                                          .metadata["preferenceType"]
                                      : "NO PREFERENCIAL",
                                  style: robotoBold.copyWith(
                                      color: ColorResources.WHITE,
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT),
                                ),
                              ),
                            )
                          ]),
                        );
                      }

                      return Container(
                        margin: EdgeInsets.only(
                          bottom: Dimensions.MARGIN_SIZE_EXTRA_LARGE,
                          left: Dimensions.MARGIN_SIZE_DEFAULT,
                          right: Dimensions.MARGIN_SIZE_DEFAULT,
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorResources.COLOR_ALIZARIN,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ]),
                        child: Stack(children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.all(
                                        Dimensions.PADDING_SIZE_SMALL),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: Dimensions
                                                .PADDING_SIZE_DEFAULT),
                                        Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Icon(Icons.error_outline,
                                                  color: ColorResources
                                                      .getPrimaryInversed(
                                                          context),
                                                  size: 32),
                                              SizedBox(
                                                  width: Dimensions
                                                      .PADDING_SIZE_SMALL),
                                              Expanded(
                                                child: Text(
                                                  card.validationErrorReader,
                                                  style: robotoRegular.copyWith(
                                                      fontSize: Dimensions
                                                          .FONT_SIZE_EXTRA_LARGE,
                                                      color: ColorResources
                                                          .getPrimaryInversed(
                                                              context)),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ]),
                                        SizedBox(
                                            height:
                                                Dimensions.PADDING_SIZE_SMALL),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ]),
                      );
                    })),
                Visibility(
                  visible: travel.isExecutingCharge,
                  child: Column(children: [
                    SpinKitSpinningLines(color: ColorResources.COLOR_PRIMARY),
                    Text(
                      "Realizando cobro...",
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                          color: ColorResources.getPrimary(context)),
                    ),
                  ]),
                ),
              ],
            );
          }),
        ]),
      ),
    );
  }

  Widget buildOptionsWhenConnected() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      SquareButton(
          icon: Icons.alt_route_outlined,
          title: getTranslated('route_feature', context),
          navigateTo: RouteSelectionScreen()),
      SquareButton(
          icon: Icons.airline_seat_recline_normal,
          title: getTranslated('driver_feature', context),
          navigateTo: DriverAuthScreen()),
      SquareButton(
          icon: Icons.credit_score_outlined,
          title: getTranslated('recharge_feature', context),
          customNavigateTo: () {
            Provider.of<CardProvider>(context, listen: false)
                .setDeviceAction(DeviceAction.READ_ONLY);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => CardRechargeScreen()));
          }),
      SquareButton(
          isDanger: true,
          icon: Icons.delete_forever,
          title: getTranslated('delete_charge_feature', context),
          customNavigateTo: () {
            Provider.of<CardProvider>(context, listen: false)
                .setDeviceAction(DeviceAction.READ_LAST_TRANSACTIONS);
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => ChargeDeleteScreen()));
          }),
    ]);
  }

  double getCardTravelInformationHeight(Operator operator) {
    double height = 275;
    if (!operator.enableManualRate) {
      height -= 30;
    }
    if (operator.priceNormal == 0) {
      height -= 30;
    }
    if (operator.priceSpecial == 0) {
      height -= 30;
    }
    return height;
  }

  void resetRatesValues() {
    _initialBalance.clear();
    //Provider.of<CardProvider>(context).setAmountToCharge("");
    //Provider.of<CardProvider>(context).setSelectedRateAmount(0);
    // setState(() {
    //   groupValue = null;
    //   title = "Seleccione una tarifa preconfigurada";
    //   isStrechedDropDown = false;
    // });
  }

  Widget buildChargeRates() {
    return Padding(
      padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
      child: Column(
        children: [
          SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          Container(
            width: MediaQuery.of(context).size.width,
            child: TextField(
              controller: _initialBalance,
              keyboardType: TextInputType.number,
              onChanged: (text) {
                Provider.of<CardProvider>(context, listen: false)
                    .setAmountToCharge(text);
                Provider.of<CardProvider>(context, listen: false)
                    .setSelectedRateAmount(0);
                setState(() {
                  groupValue = null;
                  title = "Seleccione una tarifa preconfigurada";
                });
              },
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    Provider.of<CardProvider>(context, listen: false)
                        .setAmountToCharge("");
                    _initialBalance.clear();
                  },
                  icon: Icon(
                    Icons.cancel_outlined,
                    color: Colors.black,
                  ),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(7.0),
                ),
                hintText: "Ingrese el valor a cobrar",
                labelText: "Valor a cobrar",
                enabledBorder: const OutlineInputBorder(
                  // width: 0.0 produces a thin "hairline" border
                  borderSide: const BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Dimensions.PADDING_SIZE_DEFAULT,
          ),
          Consumer<PartnerProvider>(builder: (context, partner, child) {
            if (partner.selectedPartnerInformation != null &&
                partner.selectedPartnerInformation.bus.operator.rates != null &&
                partner.selectedPartnerInformation.bus.operator.rates.length >
                    0) {
              return buildOptionsRatesList(
                  partner.selectedPartnerInformation.bus.operator.rates);
            }
            return SizedBox(
              height: 0,
            );
          }),
        ],
      ),
    );
  }

  Widget buildOptionsRatesList(List<Rates> rates) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.all(Radius.circular(7))),
        child: Column(
          children: [
            Container(
                // height: 45,
                width: double.infinity,
                padding: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                constraints: BoxConstraints(
                  minHeight: 45,
                  minWidth: double.infinity,
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: title ==
                                      "Seleccione una tarifa preconfigurada"
                                  ? Colors.grey
                                  : Colors.black),
                        ),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          FocusScope.of(context).unfocus(); //To hide keyboard

                          setState(() {
                            isStrechedDropDown = !isStrechedDropDown;
                          });
                        },
                        child: Icon(isStrechedDropDown
                            ? Icons.arrow_upward
                            : Icons.arrow_downward)),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            groupValue = null;
                            title = "Seleccione una tarifa preconfigurada";
                            isStrechedDropDown = false;
                          });
                          Provider.of<CardProvider>(context, listen: false)
                              .setSelectedRateAmount(0);
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                        )),
                  ],
                )),
            ExpandedSection(
              expand: isStrechedDropDown,
              height: 100,
              child: MyScrollbar(
                builder: (context, scrollController2) => ListView.builder(
                    padding: EdgeInsets.all(0),
                    controller: scrollController2,
                    shrinkWrap: true,
                    itemCount: rates.length,
                    itemBuilder: (context, index) {
                      return RadioListTile(
                          title: Text(Utils.calculateAmount(
                                  rates.elementAt(index).price) +
                              " --> " +
                              rates.elementAt(index).description),
                          value: index,
                          groupValue: groupValue,
                          onChanged: (val) {
                            _initialBalance.clear();
                            Provider.of<CardProvider>(context, listen: false)
                                .setAmountToCharge("");
                            Provider.of<CardProvider>(context, listen: false)
                                .setSelectedRateAmount(
                                    rates.elementAt(index).price);
                            setState(() {
                              groupValue = val;
                              title = Utils.calculateAmount(
                                      rates.elementAt(index).price) +
                                  " --> " +
                                  rates.elementAt(index).description;
                              isStrechedDropDown = false;
                            });
                          });
                    }),
              ),
            )
          ],
        ),
      ))
    ]);
  }

  void startTimer() {
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer(
      const Duration(seconds: 8),
      () {
        Provider.of<TravelProvider>(context, listen: false)
            .showCardInformation(false);
        if (_timer.isActive) {
          print("Hidding card...");
          _timer.cancel();
        }
      },
    );
  }
}
