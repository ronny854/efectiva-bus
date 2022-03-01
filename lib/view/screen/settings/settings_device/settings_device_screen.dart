import 'dart:async';

import 'package:activa_efectiva_bus/view/screen/dashboard/dashboard_screen.dart';
import 'package:activa_efectiva_bus/view/screen/settings/settings_device/settings_device_discover_screen.dart';
import 'package:flutter/material.dart';
import 'package:activa_efectiva_bus/helper/network_info.dart';
import 'package:activa_efectiva_bus/localization/language_constrants.dart';
import 'package:activa_efectiva_bus/provider/splash_provider.dart';
import 'package:activa_efectiva_bus/utill/color_resources.dart';
import 'package:activa_efectiva_bus/utill/dimensions.dart';
import 'package:activa_efectiva_bus/view/basewidget/custom_expanded_app_bar.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';

class SettingsDeviceScreen extends StatefulWidget {
  final bool isBackButtonExist;
  SettingsDeviceScreen({this.isBackButtonExist = true});

  @override
  _SettingsDeviceScreen createState() => new _SettingsDeviceScreen();
}

class _SettingsDeviceScreen extends State<SettingsDeviceScreen> {
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

    return CustomExpandedAppBar(
      canGoBack: widget.isBackButtonExist,
      title: getTranslated('device_prox', context),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
            child: ListView(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
          children: [
            SwitchListTile(
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
              title: Text(getTranslated('LOCAL_ADAPTER_ADDRESS', context)),
              subtitle: Text(_address),
            ),
            ListTile(
              title: Text(getTranslated('LOCAL_ADAPTER_NAME', context)),
              subtitle: Text(_name),
              onLongPress: null,
            ),
            Divider(),
            ListTile(
              title: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                    primary: ColorResources.getPrimaryButton(context)),
                icon: Icon(
                  Icons.bluetooth_connected,
                  color: Colors.white,
                ),
                label: Text(getTranslated('CONNECT_WITH_DEVICE', context)),
                onPressed: () async {
                  final BluetoothDevice selectedDevice =
                      await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          DeviceDiscoverScreen(checkAvailability: false),
                    ),
                  );

                  if (selectedDevice != null) {
                    print('Connect -> selected ' + selectedDevice.address);
                    _enableDevice(context, selectedDevice);
                  } else {
                    print('Connect -> no device selected');
                  }
                },
              ),
            ),
          ],
        )),
      ]),
    );
  }

  void _enableDevice(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
      builder: (context) {
        return DashBoardScreen();
      },
    ), (Route<dynamic> route) => false);
  }
}
