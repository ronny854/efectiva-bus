import 'package:activa_efectiva_bus/data/enums/device_action.dart';
import 'package:activa_efectiva_bus/provider/card_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/view/basewidget/button/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConfirmationDialog extends StatelessWidget {
  final String card;
  final String amount;

  ConfirmationDialog({this.card, this.amount});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      decoration: BoxDecoration(
          color: ColorResources.WHITE, borderRadius: BorderRadius.circular(15)),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("¡Transacción exitosa!",
                style: robotoBold.copyWith(fontSize: 20)),
            Container(
                height: 100,
                alignment: Alignment.center,
                child: Image.asset(
                  Images.recharge_icon,
                )),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "Se recargó ",
                    style: robotoRegular.copyWith(
                        color: ColorResources.COLOR_GRAY, fontSize: 18),
                  ),
                  TextSpan(
                      text: this.amount + "\$",
                      style: robotoBold.copyWith(
                          color: ColorResources.COLOR_GRAY, fontSize: 18)),
                  TextSpan(
                    text: " a la tarjeta ",
                    style: robotoRegular.copyWith(
                        color: ColorResources.COLOR_GRAY, fontSize: 18),
                  ),
                  TextSpan(
                      text: this.card,
                      style: robotoBold.copyWith(
                          color: ColorResources.COLOR_GRAY, fontSize: 18)),
                ]),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.all(15),
              child: CustomButton(
                buttonText: "Aceptar",
                onTap: () {
                  Provider.of<CardProvider>(context, listen: false)
                      .setDeviceAction(DeviceAction.CHARGE);
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
