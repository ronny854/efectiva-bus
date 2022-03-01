import 'package:activa_efectiva_bus/api/exceptions/network_exceptions.dart';
import 'package:activa_efectiva_bus/data/model/response/charge_model.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Utils {
  static String getBalanceText(ChargeResponseModel charge) {
    if (charge != null) {
      if (charge.status == "NO_BALANCE") return "No tiene saldo";
      if (charge.balance < 0) return "Se le ha prestado un pasaje";

      return charge.balance.toString();
    }
    return "";
  }

  static double getBalanceTextFontSize(ChargeResponseModel charge) {
    if (charge != null) {
      if (charge.balance < 0) return Dimensions.FONT_SIZE_EXTRA_LARGE;

      return Dimensions.FONT_SIZE_OVER_EXTRA_LARGE;
    }
    return Dimensions.FONT_SIZE_OVER_EXTRA_LARGE;
  }

  static Color getCardColor(ChargeResponseModel charge) {
    //No tiene saldo
    if (charge.status == "NO_BALANCE") return ColorResources.COLOR_ALIZARIN;

    // Tiene un pasaje restante
    if (charge.balance > 0 && charge.balance == charge.transactionAmount)
      return ColorResources.COLOR_CARIBBEAN_GREEN;

    // Ha ocupado su último pasaje
    if (charge.balance >= 0 && charge.balance < charge.transactionAmount)
      return ColorResources.COLOR_VERY_LIGHT_GRAY;

    // Se le ha prestado un pasaje
    if (charge.balance < 0) return ColorResources.COLOR_YELLOW;

    // Tiene saldo suficiente para más de un pasaje
    return ColorResources.COLOR_PRIMARY;
  }

  static String getTransportUnitType(Operator operator) {
    var operatorType = {
      'TYPE_BUS': 'BUS',
      'TYPE_TAXI': 'TAXI',
      'TYPE_EXECUTIVE': 'EJECUTIVO',
    };
    var transportType = {
      'TYPE_INTERPROVINCIAL': 'INTERPROVINCIAL',
      'TYPE_INTERCANTONAL': 'INTERCANTONAL',
      'TYPE_URBANO': 'URBANO',
    };

    if (operator.operatorType != "TYPE_BUS") {
      return operatorType[operator.operatorType];
    }
    return (operatorType[operator.operatorType] ?? "") +
        " - " +
        (transportType[operator.transportType] ?? "");
  }

  static String calculateAmount(int cents) {
    return "\$ " + (cents / 100).toStringAsPrecision(2);
  }

  static num ToAmountFromString(String amount) {
    return double.parse(amount) * 100;
  }

  static String maskCode(String code) {
    return code[0] + code[1] + "XXXX" + code[6] + code[7];
  }

  static void showErrorMessage(BuildContext context, Object error) {
    var errorMessage = getTranslated('DEFAULT_RESPONSE_ERROR', context);
    if (error is NetworkException) {
      errorMessage = error.message;
    } else if (error is Error) {
      errorMessage = error.toString();
    } else {
      errorMessage = error.toString();
    }

    EasyLoading.dismiss();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: Duration(milliseconds: 800),
      content: Text(
        errorMessage,
        style: TextStyle(color: ColorResources.WHITE),
      ),
      backgroundColor: Colors.red,
    ));
  }
}
