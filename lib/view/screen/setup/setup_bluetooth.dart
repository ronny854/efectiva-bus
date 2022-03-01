import 'dart:async';

import 'package:activa_efectiva_bus/api/exceptions/network_exceptions.dart';
import 'package:activa_efectiva_bus/data/enums/connection_status.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/provider/device_provider.dart';
import 'package:activa_efectiva_bus/provider/partner_provider.dart';
import 'package:activa_efectiva_bus/provider/route_provider.dart';
import 'package:activa_efectiva_bus/utill/utils.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_app_bar.dart';
import 'package:activa_efectiva_bus/view/screen/dashboard/dashboard_screen.dart';
import 'package:activa_efectiva_bus/view/screen/setup/select_bonded_device.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/splash_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

// This screen is used for verify if bluetooth connection is enabled and if device (mobile, tablet) has already bounded with proximity reader
// We match available bounded devices with the MAC address assigned as device of unit transport
class SetupBluetoothScreen extends StatefulWidget {
  final bool isBackButtonExist;
  final Bus bus;
  final Device device;
  SetupBluetoothScreen({this.isBackButtonExist = true, this.bus, this.device});

  @override
  _SetupBluetoothScreen createState() => new _SetupBluetoothScreen();
}

class _SetupBluetoothScreen extends State<SetupBluetoothScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;

  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if ((await FlutterBluetoothSerial.instance.isEnabled) ?? false) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    NetworkInfo.checkConnectivity(context);
    Provider.of<SplashProvider>(context, listen: false).setFromSetting(true);

    return Scaffold(
      body: Column(children: [
        CustomAppBar(
            title: getTranslated('device_prox', context),
            isBackButtonExist: widget.isBackButtonExist),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _buildAdviceCard(),
          Divider(),
          Expanded(
              child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            children: [
              SwitchListTile(
                activeColor: ColorResources.getPrimaryButton(context),
                title: Text(getTranslated('ENABLE_BLUETOOTH', context)),
                value: _bluetoothState.isEnabled,
                onChanged: (bool value) {
                  // Do the request and update with the true value then
                  future() async {
                    // async lambda seems to not working
                    if (value)
                      await FlutterBluetoothSerial.instance.requestEnable();
                    else
                      await FlutterBluetoothSerial.instance.requestDisable();
                  }

                  future().then((_) {
                    setState(() {});
                  });
                },
              ),
              ListTile(
                title: Text(getTranslated('BLUETOOTH_STATUS', context)),
                subtitle: Text(
                    _bluetoothState.toString() == "BluetoothState.STATE_ON"
                        ? getTranslated('ACTIVE', context)
                        : getTranslated('INACTIVE', context)),
                trailing: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: ColorResources.getPrimaryButton(context)),
                  label: Text(getTranslated('EXPLORE_DEVICES', context)),
                  icon: Icon(Icons.important_devices),
                  onPressed: () {
                    FlutterBluetoothSerial.instance.openSettings();
                  },
                ),
              ),
              ListTile(
                title: Text(getTranslated('TRANSPORT_NAME', context)),
                subtitle: Text(widget.bus.matricula),
              ),
              ListTile(
                title: Text(getTranslated('LOCAL_ADAPTER_ADDRESS', context)),
                subtitle: Text(_address),
              ),
              ListTile(
                title: Text(getTranslated('LOCAL_ADAPTER_NAME', context)),
                subtitle: Text(_name),
                onLongPress: null,
              ),
              ListTile(
                title: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: ColorResources.getPrimaryButton(context)),
                  icon: Icon(
                    Icons.bluetooth_connected,
                    color: Colors.white,
                  ),
                  label: Text(getTranslated('CONNECT_WITH_DEVICE', context)),
                  onPressed: !_bluetoothState.isEnabled
                      ? null
                      : () async {
                          Provider.of<DeviceProvider>(context, listen: false)
                              .setConnectionStatus(DeviceStatus.UNAVAILABLE);

                          await EasyLoading.show(
                              status: getTranslated('PLEASE_WAIT', context));

                          final BluetoothDevice selectedDevice =
                              await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectBondedDevicePage(
                                  checkAvailability: true,
                                  expectedMAC: widget.device.mac,
                                );
                              },
                            ),
                          );

                          if (selectedDevice != null) {
                            print('Connect -> selected ' +
                                selectedDevice.address);
                            _enableDevice(context, selectedDevice);
                          } else {
                            EasyLoading.dismiss();

                            print('Connect -> no device selected');
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              duration: Duration(seconds: 4),
                              content: Text(
                                "No se encontró el lector de proximidad asignado a ésta unidad de transporte.",
                                style: TextStyle(color: ColorResources.WHITE),
                              ),
                              backgroundColor: Colors.red,
                            ));
                          }
                        },
                ),
              ),
            ],
          )),
        ])),
      ]),
    );
  }

  Widget _buildAdviceCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.info_outline,
              size: 48,
            ),
            title: Text(
              'Recuerde vincular el lector de proximidad con éste dispositivo.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.justify,
            ),
            subtitle: Text(
              'Pulse el botón Explorar para realizar la vinculación si aún no lo ha hecho.',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // If match between assigned device mac address with bounded devices is successfully
  void _enableDevice(BuildContext context, BluetoothDevice server) {
    // Get routes of operator
    // TODO: Maybe we should find another place to call the operator routes for first time (Consider move this call to DashBoardScreen before try connection)
    Provider.of<RouteProvider>(context, listen: false)
        .getOperatorRoutes(widget.bus.operator.id)
        .then((value) async {
      // Save the current MAC address on preferences to later use this value and make connection directly on DashBoardScreen
      await Provider.of<DeviceProvider>(context, listen: false)
          .saveSelectedMacAddress(server.address);
      // Save the current bus ID on preferences to later use this value for filter from local DB
      await Provider.of<PartnerProvider>(context, listen: false)
          .saveSelectedTransportUnit(widget.bus.id);
      // Save the current operator ID of the selected bus (We use this value to allow drivers log in only if they are assigned to this operator)
      await Provider.of<PartnerProvider>(context, listen: false)
          .saveSelectedOperatorID(widget.bus.operator.id);
      EasyLoading.dismiss();
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (context) {
          return DashBoardScreen();
        },
      ), (Route<dynamic> route) => false);
    }).catchError((Object error) {
      Utils.showErrorMessage(context, error);
    });
  }
}
