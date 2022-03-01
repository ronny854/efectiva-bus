import 'package:activa_efectiva_bus/data/enums/device_action.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/provider/card_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:activa_efectiva_bus/view/basewidget/card_information.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_app_bar.dart';
import 'package:activa_efectiva_bus/view/screen/card_recharge/widget/balance_selection.dart';
import 'package:activa_efectiva_bus/view/screen/card_recharge/widget/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class CardRechargeScreen extends StatefulWidget {
  final bool redirect;

  const CardRechargeScreen({this.redirect = true});
  @override
  _CardRechargeScreenState createState() => _CardRechargeScreenState();
}

class _CardRechargeScreenState extends State<CardRechargeScreen> {
  String amount = "0.3";
  int balanceIndex = 1;
  TextEditingController txtBalanceController = TextEditingController();
  TextEditingController txtCardCodeController = TextEditingController();

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
    return WillPopScope(
        onWillPop: () async {
          if (Provider.of<CardProvider>(context, listen: false).isRecharging) {
            return false;
          }
          Provider.of<CardProvider>(context, listen: false).setCardReaded(null);
          Provider.of<CardProvider>(context, listen: false)
              .setDeviceAction(DeviceAction.CHARGE);
          return true;
        },
        child: Scaffold(
            backgroundColor: ColorResources.getIconBg(context),
            body: Column(
              children: [
                CustomAppBar(
                  title: getTranslated('recharge_feature', context),
                  isBackButtonExist: true,
                  onExit: () {
                    Provider.of<CardProvider>(context, listen: false)
                        .setCardReaded(null);
                    Provider.of<CardProvider>(context, listen: false)
                        .setDeviceAction(DeviceAction.CHARGE);
                    Navigator.of(context).pop();
                  },
                ),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0),
                            topRight: Radius.circular(0))),
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                leading: Icon(
                                  Icons.attach_money_outlined,
                                  size: 50,
                                  color: ColorResources.getPrimary(context),
                                ),
                                title: Text(
                                  'Añadir balance al saldo de la tarjeta',
                                  style: TextStyle(fontSize: 18),
                                ),
                                subtitle: Text(
                                  'Seleccione o ingrese el monto ha ser acreditado en la tarjeta.',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                              thickness: 2, color: ColorResources.getChatIcon(context)),
                          Container(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          left: 15, right: 15, top: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color: balanceIndex == 0
                                                          ? ColorResources
                                                              .COLOR_PRIMARY
                                                          : ColorResources
                                                              .getHint(context),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.2),
                                                          spreadRadius: 1,
                                                          blurRadius: 7,
                                                          offset: Offset(0,
                                                              1), // changes position of shadow
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15)),
                                                  alignment: Alignment.center,
                                                  height: 70,
                                                  child: TextField(
                                                    onTap: () {
                                                      setState(() {
                                                        balanceIndex = 0;
                                                      });
                                                    },
                                                    textAlign: TextAlign.center,
                                                    cursorColor:
                                                        ColorResources.GREY,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    controller:
                                                        txtBalanceController,
                                                    maxLength: 5,
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        color: balanceIndex == 3
                                                            ? ColorResources
                                                                .WHITE
                                                            : ColorResources
                                                                .GREY),
                                                    decoration: InputDecoration(
                                                        disabledBorder:
                                                            InputBorder.none,
                                                        border:
                                                            InputBorder.none,
                                                        counterText: '',
                                                        labelStyle: robotoRegular
                                                            .copyWith(
                                                                color:
                                                                    ColorResources
                                                                        .GREY),
                                                        enabledBorder:
                                                            InputBorder.none),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      txtBalanceController
                                                          .clear();

                                                      setState(() {
                                                        balanceIndex = 1;
                                                        amount = "0.3";
                                                      });
                                                    },
                                                    child: BalanceSelection(
                                                      colorBoxDecoration:
                                                          balanceIndex == 1
                                                              ? ColorResources
                                                                  .COLOR_PRIMARY
                                                              : ColorResources
                                                                  .getHint(
                                                                      context),
                                                      colorText: balanceIndex ==
                                                              1
                                                          ? ColorResources.WHITE
                                                          : ColorResources.GREY,
                                                      amount: "0.30 \$",
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      txtBalanceController
                                                          .clear();
                                                      setState(() {
                                                        balanceIndex = 2;
                                                        amount = "1";
                                                      });
                                                    },
                                                    child: BalanceSelection(
                                                      amount: "1 \$",
                                                      colorText: balanceIndex ==
                                                              2
                                                          ? ColorResources.WHITE
                                                          : ColorResources.GREY,
                                                      colorBoxDecoration:
                                                          balanceIndex == 2
                                                              ? ColorResources
                                                                  .COLOR_PRIMARY
                                                              : ColorResources
                                                                  .getHint(
                                                                      context),
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      txtBalanceController
                                                          .clear();
                                                      setState(() {
                                                        balanceIndex = 3;
                                                        amount = "3";
                                                      });
                                                    },
                                                    child: BalanceSelection(
                                                      colorBoxDecoration:
                                                          balanceIndex == 3
                                                              ? ColorResources
                                                                  .COLOR_PRIMARY
                                                              : ColorResources
                                                                  .getHint(
                                                                      context),
                                                      colorText: balanceIndex ==
                                                              3
                                                          ? ColorResources.WHITE
                                                          : ColorResources.GREY,
                                                      amount: "3 \$",
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    txtBalanceController
                                                        .clear();
                                                    setState(() {
                                                      balanceIndex = 4;
                                                      amount = "5";
                                                    });
                                                  },
                                                  child: BalanceSelection(
                                                    amount: "5 \$",
                                                    colorText: balanceIndex == 4
                                                        ? ColorResources.WHITE
                                                        : ColorResources.GREY,
                                                    colorBoxDecoration:
                                                        balanceIndex == 4
                                                            ? ColorResources
                                                                .COLOR_PRIMARY
                                                            : ColorResources
                                                                .getHint(
                                                                    context),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      txtBalanceController
                                                          .clear();
                                                      setState(() {
                                                        balanceIndex = 5;
                                                        amount = "10";
                                                      });
                                                    },
                                                    child: BalanceSelection(
                                                      colorBoxDecoration:
                                                          balanceIndex == 5
                                                              ? ColorResources
                                                                  .COLOR_PRIMARY
                                                              : ColorResources
                                                                  .getHint(
                                                                      context),
                                                      colorText: balanceIndex ==
                                                              5
                                                          ? ColorResources.WHITE
                                                          : ColorResources.GREY,
                                                      amount: "10 \$",
                                                    )),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                  onTap: () {
                                                    txtBalanceController
                                                        .clear();
                                                    setState(() {
                                                      balanceIndex = 6;
                                                      amount = "15";
                                                    });
                                                  },
                                                  child: BalanceSelection(
                                                    colorText: balanceIndex == 6
                                                        ? ColorResources.WHITE
                                                        : ColorResources.GREY,
                                                    colorBoxDecoration:
                                                        balanceIndex == 6
                                                            ? ColorResources
                                                                .COLOR_PRIMARY
                                                            : ColorResources
                                                                .getHint(
                                                                    context),
                                                    amount: "15 \$",
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: InkWell(
                                                    onTap: () {
                                                      txtBalanceController
                                                          .clear();
                                                      setState(() {
                                                        balanceIndex = 7;
                                                        amount = "20";
                                                      });
                                                    },
                                                    child: BalanceSelection(
                                                      colorBoxDecoration:
                                                          balanceIndex == 7
                                                              ? ColorResources
                                                                  .COLOR_PRIMARY
                                                              : ColorResources
                                                                  .getHint(
                                                                      context),
                                                      colorText: balanceIndex ==
                                                              7
                                                          ? ColorResources.WHITE
                                                          : ColorResources.GREY,
                                                      amount: "20 \$",
                                                    )),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                              "Deslice la tarjeta por el sensor para capturar el código o ingréselo manualmente.",  style: TextStyle(fontSize: 16)),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Expanded(
                                                child: TextField(
                                                  controller:
                                                      txtCardCodeController,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    hintText:
                                                        'Código de la tarjeta',
                                                    suffixIcon: IconButton(
                                                      onPressed: () {
                                                        FocusScope.of(context).unfocus();
                                                        txtCardCodeController
                                                            .clear();
                                                      },
                                                      icon: Icon(Icons.clear),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20,
                                              ),
                                              ElevatedButton.icon(
                                                icon: Icon(Icons.search),
                                                style: ElevatedButton.styleFrom(
                                                    primary: ColorResources
                                                        .getPrimary(context)),
                                                label: Text(
                                                  'Buscar',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                onPressed: () async {
                                                  FocusScope.of(context).unfocus();
                                                  Provider.of<CardProvider>(
                                                          context,
                                                          listen: false)
                                                      .setFetchingCardInfo(
                                                          true);
                                                  Provider.of<CardProvider>(
                                                          context,
                                                          listen: false)
                                                      .getCardByCode(
                                                          txtCardCodeController
                                                              .text)
                                                      .then((value) {
                                                    txtCardCodeController
                                                        .clear();
                                                    Provider.of<CardProvider>(
                                                            context,
                                                            listen: false)
                                                        .setFetchingCardInfo(
                                                            false);
                                                  }).catchError((Object error) {
                                                    Provider.of<CardProvider>(
                                                            context,
                                                            listen: false)
                                                        .setFetchingCardInfo(
                                                            false);
                                                    Provider.of<CardProvider>(
                                                        context,
                                                        listen: false)
                                                        .setCardReaded(
                                                        null);
                                                    Utils.showErrorMessage(
                                                        context, error);
                                                  });
                                                },
                                              )
                                            ],
                                          ),

                                          SizedBox(
                                            height: 20,
                                          ),
                                          //Card reader by sensor

                                          Consumer<CardProvider>(
                                              builder: (context, card, child) {
                                            if (card.cardReaded != null) {
                                              return CardInformation(
                                                card: card.cardReaded,
                                              );
                                            }
                                            return SizedBox(
                                              height: 0,
                                            );
                                          }),
                                          Consumer<CardProvider>(
                                              builder: (context, card, child) {
                                            if (card.fetchingCardInfo) {
                                              return buildLoadingMessage(
                                                  "Buscando...");
                                            }
                                            return SizedBox(
                                              height: 0,
                                            );
                                          }),
                                          Consumer<CardProvider>(
                                              builder: (context, card, child) {
                                            if (card.isRecharging) {
                                              return buildLoadingMessage(
                                                  "Recargando...");
                                            }
                                            return SizedBox(
                                              height: 0,
                                            );
                                          }),
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
                    ),
                  ),
                )
              ],
            ),
            floatingActionButton:
                Consumer<CardProvider>(builder: (context, card, child) {
              if (card.cardReaded == null) {
                return SizedBox(
                  height: 0,
                );
              }
              return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                FloatingActionButton(
                  tooltip: "Recargar",
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                  ),
                  onPressed: !card.isRecharging
                      ? () {
                          if (balanceIndex == 0 &&
                              txtBalanceController.text == "") {
                            Utils.showErrorMessage(
                                context, "Ingrese el valor a recargar");
                            return;
                          }
                          String code = card.cardReaded.code;
                          String amountToRecharge =
                              txtBalanceController.text != ""
                                  ? txtBalanceController.text
                                  : amount;

                          PartnerInformationResponse partnerInfo =
                              Provider.of<PartnerProvider>(context,
                                      listen: false)
                                  .selectedPartnerInformation;
                          Provider.of<CardProvider>(context, listen: false)
                              .setIsRecharging(true);
                          Provider.of<CardProvider>(context, listen: false)
                              .rechargeCard(partnerInfo.bus.id, code,
                                  Utils.ToAmountFromString(amountToRecharge))
                              .then((value) {
                            txtCardCodeController.clear();
                            Provider.of<CardProvider>(context, listen: false)
                                .setIsRecharging(false);
                            Provider.of<CardProvider>(context, listen: false)
                                .setCardReaded(null);
                            return showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (BuildContext context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    child: ConfirmationDialog(
                                        amount: amountToRecharge,
                                        card: Utils.maskCode(code)),
                                  );
                                });
                          }).catchError((Object error) {
                            Provider.of<CardProvider>(context, listen: false)
                                .setIsRecharging(false);
                            Utils.showErrorMessage(context, error);
                          });
                        }
                      : null,
                  heroTag: null,
                ),
                SizedBox(
                  width: 18,
                ),
                FloatingActionButton(
                  tooltip: "Cancelar",
                  backgroundColor: Colors.red,
                  child: Icon(Icons.clear),
                  onPressed: !card.isRecharging
                      ? () {
                          Provider.of<CardProvider>(context, listen: false)
                              .setCardReaded(null);
                        }
                      : null,
                  heroTag: null,
                )
              ]);
            })));
  }

  Widget buildLoadingMessage(String message) {
    return Column(children: [
      SpinKitSpinningLines(color: ColorResources.COLOR_PRIMARY),
      SizedBox(
        height: 10,
      ),
      Text(
        message,
        style: robotoBold.copyWith(
            fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
            color: ColorResources.getPrimary(context)),
      ),
    ]);
  }
}
