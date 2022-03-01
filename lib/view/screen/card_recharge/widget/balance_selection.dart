import 'package:activa_efectiva_bus/utill/custom_themes.dart';

import 'package:flutter/material.dart';

class BalanceSelection extends StatelessWidget {
  final Color colorBoxDecoration;
  final Color colorText;
  final String amount;
  BalanceSelection({this.colorBoxDecoration, this.colorText, this.amount});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: colorBoxDecoration,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(0, 1), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(15)),
      alignment: Alignment.center,
      height: 70,
      child: Text(amount,
          style: robotoRegular.copyWith(
            color: colorText,
            fontSize: 25,
          )),
    );
  }
}
