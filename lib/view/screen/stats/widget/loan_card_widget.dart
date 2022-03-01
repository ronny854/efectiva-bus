import 'package:activa_efectiva_bus/data/model/response/stat_model.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoanCardWidget extends StatelessWidget {
  final StatModel stats;

  LoanCardWidget(this.stats);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      //margin: EdgeInsets.only(left: 22),
      padding: EdgeInsets.only(left: 12, right: 11, bottom: 0, top: 10),
      child: Column(
        children: [
          Container(
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorResources.COLOR_WHITE_SMOKE),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorResources.SOFT_BLUE),
                    child: Text(
                      "PREFERENCIALES",
                      style: robotoRegular.copyWith(
                        color: ColorResources.WHITE,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 15),
                    alignment: Alignment.centerRight,
                    child: Tooltip(
                      message: 'Número de pasajeros: ' + stats.totalPreference.toString(),
                      child: Text(
                        stats.preferencialAmount.toString() + " USD",
                        textAlign: TextAlign.center,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorResources.COLOR_WHITE_SMOKE),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorResources.YELLOW),
                    child: Text(
                      "NO PREFERENCIALES",
                      style: robotoRegular.copyWith(
                        color: ColorResources.WHITE,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 15),
                    alignment: Alignment.centerRight,
                    child: Tooltip(
                      message: 'Número de pasajeros: ' + stats.totalNoPreference.toString(),
                      child: Text(
                        stats.noPreferencialAmount.toString() + " USD",
                        textAlign: TextAlign.center,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Container(
            height: 48,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: ColorResources.COLOR_WHITE_SMOKE),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorResources.COLUMBIA_BLUE),
                    child: Text(
                      "RECARGAS",
                      style: robotoRegular.copyWith(
                        color: ColorResources.WHITE,
                        fontSize: Dimensions.FONT_SIZE_DEFAULT,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 20, right: 15),
                    alignment: Alignment.centerRight,
                    child: Tooltip(
                      message: 'Número de recargas: ' + stats.rechargesCount.toString(),
                      child: Text(
                        stats.rechargesAmount.toString() + " USD",
                        textAlign: TextAlign.center,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.FONT_SIZE_EXTRA_LARGE,
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
