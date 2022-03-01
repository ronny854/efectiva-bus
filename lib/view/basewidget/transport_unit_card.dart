import 'package:activa_efectiva_bus/data/enums/connection_status.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/device_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/view/screen/dashboard/dashboard_screen.dart';
import 'package:activa_efectiva_bus/view/screen/setup/setup_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/custom_themes.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/screen/transport/transport_information.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class TransportUnitCard extends StatelessWidget {
  final PartnerInformationResponse partnerInformation;
  final String redirectScreen;
  final bool checkConnection;
  TransportUnitCard(
      {@required this.partnerInformation,
      @required this.redirectScreen,
      @required this.checkConnection});

  @override
  Widget build(BuildContext context) {
    var operatorType = {
      'TYPE_BUS': 'BUS',
      'TYPE_TAXI': 'TAXI',
      'TYPE_EXECUTIVE': 'EJECUTIVO',
    };

    return InkWell(
      onTap: () async {
        final lastDeviceMac =
            Provider.of<DeviceProvider>(context, listen: false)
                .getSelectedMacAddress();

        if (checkConnection && lastDeviceMac == partnerInformation.device.mac) {
          Provider.of<DeviceProvider>(context, listen: false)
              .setConnectionStatus(DeviceStatus.UNAVAILABLE);
          await EasyLoading.show(status: getTranslated('PLEASE_WAIT', context));
          await Provider.of<RouteProvider>(context, listen: false)
              .getOperatorRoutes(partnerInformation.bus.operator.id);
          EasyLoading.dismiss();
          Navigator.pushAndRemoveUntil(
              context,
              PageRouteBuilder(
                transitionDuration: Duration(milliseconds: 1000),
                pageBuilder: (context, anim1, anim2) => DashBoardScreen(),
              ),
              (route) => false);
          return;
        }

        Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: Duration(milliseconds: 1000),
              pageBuilder: (context, anim1, anim2) => redirectScreen == "setup"
                  ? SetupBluetoothScreen(
                      bus: partnerInformation.bus,
                      device: partnerInformation.device,
                    )
                  : TransportInformationScreen(),
            ));
      },
      child: Container(
        height: 95,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.secondary,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5)
          ],
        ),
        child: Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Padding(
              padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: Dimensions.PADDING_SIZE_SMALL),
                  Row(children: [
                    Icon(Icons.domain,
                        color: ColorResources.getPrimary(context), size: 24),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Hero(
                            tag:
                                'operator-${partnerInformation.bus.operator.id}',
                            child: Text(
                              partnerInformation.bus.operator.name ?? "",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: robotoBold.copyWith(
                                  color: ColorResources.getPrimary(context)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ]),
                  SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                  Row(children: [
                    Icon(
                        partnerInformation.bus.operator.operatorType ==
                                "TYPE_BUS"
                            ? Icons.directions_bus
                            : Icons.local_taxi,
                        color: ColorResources.getPrimary(context),
                        size: 24),
                    SizedBox(width: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                    Hero(
                      tag: 'bus-${partnerInformation.bus.id}',
                      child: Text(
                        partnerInformation.bus.matricula ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: robotoBold.copyWith(
                            color: ColorResources.getPrimary(context)),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ]),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              height: 20,
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
              decoration: BoxDecoration(
                color: ColorResources.getPrimary(context),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
              ),
              child: Center(
                child: Hero(
                  tag: 'type-${partnerInformation.bus.operator.id}',
                  child: Text(
                    operatorType[partnerInformation.bus.operator.operatorType],
                    style: robotoRegular.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL),
                  ),
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
