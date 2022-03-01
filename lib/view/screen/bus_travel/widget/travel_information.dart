import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/driver_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/utill/images.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:provider/provider.dart';

class TravelInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PartnerProvider>(builder: (context, partner, child) {
      if (partner.selectedPartnerInformation != null) {
        return Column(
          children: <Widget>[
            buildCardTravelInformation(partner.selectedPartnerInformation.bus, context),
          ],
        );
      }

      return SizedBox(
        height: 0,
      );
    });
  }


  Widget buildCardTravelInformation(Bus bus, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 0,
        left: 0,
        right: 0,
      ),
      width: MediaQuery.of(context).size.width,
      height: getCardTravelInformationHeight(bus.operator),
      child: Stack(children: [
        Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            flex: 7,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    minVerticalPadding: 10,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    horizontalTitleGap: 0.0,
                    title: Text('Operadora de transporte',
                        style: robotoBold.copyWith(
                            fontSize: 16,
                            color: ColorResources.getPrimary(context))),
                    subtitle: Text(
                      bus.operator.name,
                      style: robotoBold.copyWith(
                          fontSize: 14, color: ColorResources.COLOR_GRAY),
                    ),
                    leading: Icon(
                      Icons.domain,
                      color: ColorResources.getPrimary(context),
                      size: 30,
                    ),
                  ),
                  bus.operator.priceSpecial == 0
                      ? SizedBox(
                    height: 0,
                  )
                      : ListTile(
                    minVerticalPadding: 10,
                    visualDensity:
                    VisualDensity(horizontal: 0, vertical: -4),
                    horizontalTitleGap: 0.0,
                    title: Text('Tarifa preferencial',
                        style: robotoBold.copyWith(
                            fontSize: 16,
                            color: ColorResources.getPrimary(context))),
                    subtitle: Text(
                        Utils.calculateAmount(bus.operator.priceNormal),
                        style: robotoBold.copyWith(
                            fontSize: 14,
                            color: ColorResources.COLOR_GRAY)),
                    leading: Icon(
                      Icons.accessible,
                      color: ColorResources.getPrimary(context),
                      size: 30,
                    ),
                  ),
                  bus.operator.priceNormal == 0
                      ? SizedBox(
                    height: 0,
                  )
                      : ListTile(
                    minVerticalPadding: 10,
                    visualDensity:
                    VisualDensity(horizontal: 0, vertical: -4),
                    horizontalTitleGap: 0.0,
                    title: Text('Tarifa no preferencial',
                        style: robotoBold.copyWith(
                            fontSize: 16,
                            color: ColorResources.getPrimary(context))),
                    subtitle: Text(
                        Utils.calculateAmount(bus.operator.priceSpecial),
                        style: robotoBold.copyWith(
                            fontSize: 14,
                            color: ColorResources.COLOR_GRAY)),
                    leading: Icon(
                      Icons.accessibility_outlined,
                      color: ColorResources.getPrimary(context),
                      size: 30,
                    ),
                  ),
                  ListTile(
                    minVerticalPadding: 10,
                    visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    horizontalTitleGap: 0.0,
                    title: Text('Ruta',
                        style: robotoBold.copyWith(
                            fontSize: 16,
                            color: ColorResources.getPrimary(context))),
                    subtitle: Consumer<RouteProvider>(
                        builder: (context, route, child) {
                          return Text(
                              route.selectedRoute != null
                                  ? route.selectedRoute.name
                                  : getTranslated(
                                  'TRANSPORT_UNIT_INACTIVE', context),
                              style: robotoBold.copyWith(
                                  fontSize: 14,
                                  color: route.selectedRoute != null &&
                                      route.selectedRoute.name != ""
                                      ? ColorResources.COLOR_GRAY
                                      : ColorResources.RED));
                        }),
                    leading: Icon(
                      Icons.location_on_sharp,
                      color: ColorResources.getPrimary(context),
                      size: 30,
                    ),
                  ),
                  !bus.operator.enableManualRate
                      ? SizedBox(
                    height: 0,
                  )
                      : ListTile(
                    minVerticalPadding: 10,
                    visualDensity:
                    VisualDensity(horizontal: 0, vertical: -4),
                    horizontalTitleGap: 0.0,
                    title: Text("Tarifa variable",
                        style: robotoBold.copyWith(
                            fontSize: 16,
                            color: ColorResources.getPrimary(context))),
                    subtitle: Text(
                        "Puede ingresar la tarifa que desea cobrar por el recorrido.",
                        style: robotoBold.copyWith(
                            fontSize: 14,
                            color: ColorResources.COLOR_GRAY)),
                    leading: Icon(
                      Icons.monetization_on_outlined,
                      color: ColorResources.getPrimary(context),
                      size: 30,
                    ),
                  ),
                  // Card balance
                ],
              ),
            ),
          ),
          // CURRENT DRIVER INFORMATION
          Expanded(
            flex: 4,
            child: Consumer<DriverProvider>(builder: (context, driver, child) {
              print(driver.driverInformation);
              if (driver.driverInformation == null) {
                return Column(children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 52, //we give the imag
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(0),
                        child: Image.asset(
                          Images.no_driver,
                        ),
                      ) // e a radius of 50

                  ),
                  Text(
                    "SIN CONDUCTOR",
                    style: robotoBold.copyWith(
                        fontSize: 15, color: ColorResources.RED),
                  ),
                ]);
              }

              return Column(children: [
                SizedBox(height: Dimensions.PADDING_SIZE_LARGE),
                Text('Conductor',
                    style: robotoBold.copyWith(
                        fontSize: 16,
                        color: ColorResources.getPrimary(context))),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                CircleAvatar(
                  radius: 50, //we give the image a radius of 50
                  backgroundImage:
                  NetworkImage(driver.driverInformation.photoUrl),
                ),
                SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                Text(
                  driver.driverInformation.names,
                  style: robotoBold.copyWith(
                      fontSize: 14, color: ColorResources.COLOR_GRAY),
                  textAlign: TextAlign.center,
                ),
              ]);
            }),
          ),
        ]),
      ]),
    );
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
}
