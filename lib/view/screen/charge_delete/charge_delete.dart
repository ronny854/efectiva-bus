import 'package:activa_efectiva_bus/data/enums/device_action.dart';
import 'package:activa_efectiva_bus/provider/card_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChargeDeleteScreen extends StatefulWidget {
  final bool redirect;

  const ChargeDeleteScreen({this.redirect = true});
  @override
  _ChargeDeleteScreenState createState() => _ChargeDeleteScreenState();
}

class _ChargeDeleteScreenState extends State<ChargeDeleteScreen> {
  String text = '';

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
        Provider.of<CardProvider>(context, listen: false)
            .setLastCardChargedTrxs(null);
        Provider.of<CardProvider>(context, listen: false)
            .setDeviceAction(DeviceAction.CHARGE);
        return true;
      },
      child: Scaffold(
        backgroundColor: ColorResources.getIconBg(context),
        body: Column(
          children: [
            CustomAppBar(
                title: getTranslated('delete_charge_feature', context),
                isBackButtonExist: true,
                onExit: () {
                  Provider.of<CardProvider>(context, listen: false)
                      .setLastCardChargedTrxs(null);
                  Provider.of<CardProvider>(context, listen: false)
                      .setDeviceAction(DeviceAction.CHARGE);
                  Navigator.of(context).pop();
                }),
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
                              Icons.credit_card_off,
                              size: 50,
                              color: ColorResources.getPrimary(context),
                            ),
                            title: Text(
                              'Devolución de pasaje',
                              style: TextStyle(fontSize: 18),
                            ),
                            subtitle: Text(
                              'Deslice la tarjeta por el sensor para obtener la información del último pasaje cobrado en ésta unidad de transporte.',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                          thickness: 2,
                          color: ColorResources.getChatIcon(context)),
                      Consumer<CardProvider>(builder: (context, card, child) {
                        if (card.fetchingCardInfo) {
                          return buildLoadingMessage("Buscando registros");
                        }
                        return SizedBox(
                          height: 0,
                        );
                      }),
                      Consumer<CardProvider>(builder: (context, card, child) {
                        if (card.lastCardChargedTrxs == null) {
                          return SizedBox(
                            height: 0,
                          );
                        }

                        return ListView.builder(
                          itemCount: card.lastCardChargedTrxs.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => Card(
                            elevation: 3,
                            child: ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    Utils.calculateAmount(
                                        card.lastCardChargedTrxs[index].amount),
                                    style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_OVER_LARGE,
                                        color: ColorResources.COLOR_DIM_GRAY),
                                  ),
                                  Text(
                                    Utils.maskCode(card
                                        .lastCardChargedTrxs[index].card.code),
                                    style: robotoBold.copyWith(
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_LARGE,
                                        color: ColorResources.COLOR_DIM_GRAY),
                                  ),
                                  Text(
                                    card.lastCardChargedTrxs[index].card
                                        .metadata.names,
                                    style: robotoBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_LARGE,
                                        color: ColorResources.COLOR_DIM_GRAY),
                                  ),
                                  Text(
                                    card.lastCardChargedTrxs[index].created,
                                    style: robotoBold.copyWith(
                                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                                        color: ColorResources.COLOR_DIM_GRAY),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                              trailing: IconButton(
                                padding: EdgeInsets.zero,
                                icon: Icon(
                                  Icons.delete_forever_sharp,
                                  color: ColorResources.RED,
                                  size: 48,
                                ),
                                onPressed: () {
                                  EasyLoading.show(
                                      status: getTranslated(
                                          'PLEASE_WAIT', context));
                                  Provider.of<CardProvider>(context,
                                          listen: false)
                                      .deleteTransaction(
                                          card.lastCardChargedTrxs[index].id, index)
                                      .then((value) {
                                    EasyLoading.dismiss();
                                  }).catchError((Object error) {
                                    Provider.of<CardProvider>(context,
                                            listen: false)
                                        .setIsRecharging(false);
                                    Utils.showErrorMessage(context, error);
                                  });
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                      // Consumer<CardProvider>(builder: (context, card, child) {
                      //   if (card.lastCardChargedTrxs == null ||
                      //       card.lastCardChargedTrxs.length <= 1) {
                      //     return SizedBox(
                      //       height: 0,
                      //     );
                      //   }
                      //   return Padding(
                      //     padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      //     child: ElevatedButton.icon(
                      //       style: ElevatedButton.styleFrom(
                      //           primary: ColorResources.RED),
                      //       icon: Icon(
                      //         Icons.delete_forever_sharp,
                      //         color: ColorResources.WHITE,
                      //       ),
                      //       label: Text("Anular todo"),
                      //       onPressed: () {},
                      //     ),
                      //   );
                      // }),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
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
