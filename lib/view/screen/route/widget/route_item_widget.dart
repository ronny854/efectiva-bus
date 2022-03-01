import 'package:activa_efectiva_bus/data/model/response/route_model.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:flutter/material.dart';

class RouteItemWidget extends StatelessWidget {
  final RouteModel product;

  RouteItemWidget({this.product});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          //     builder: (context) => ProductDetailsScreen(
          //       product: product,
          //     )));
        },
        child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
                color: ColorResources.WHITE,
                borderRadius:
                    BorderRadius.circular(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: Dimensions.PADDING_SIZE_SMALL),
                        child: Text(
                          product.name,
                          style: robotoRegular.copyWith(
                              fontSize: 13, color: ColorResources.BLACK),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
