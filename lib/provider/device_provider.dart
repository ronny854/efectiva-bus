import 'package:activa_efectiva_bus/data/enums/connection_status.dart';
import 'package:activa_efectiva_bus/data/repository/device_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class DeviceProvider extends ChangeNotifier {
  final DeviceRepo deviceRepo;

  DeviceProvider({@required this.deviceRepo});

  //DeviceProvider();

  String _selectedMAC = "";
  String get selectedMAC => _selectedMAC;

  BluetoothConnection _connection;
  BluetoothConnection get connection => _connection;

  DeviceStatus _deviceStatus = DeviceStatus.UNAVAILABLE;
  DeviceStatus get deviceStatus => _deviceStatus;

  Future<bool> saveSelectedMacAddress(String macAddress) async {
    try {
      await deviceRepo.saveSelectedMacAddress(macAddress);

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  String getSelectedMacAddress() {
    return deviceRepo.getSelectedMacAddress();
  }

  Future<bool> clearSelectedMacAddress() async {
    return deviceRepo.clearSelectedMacAddress();
  }

  void setSelectedMAC(String mac) {
    _selectedMAC = mac;
    notifyListeners();
  }

  void setConnection(BluetoothConnection connection) {
    _connection = connection;
    notifyListeners();
  }

  void setConnectionStatus(DeviceStatus status) {
    _deviceStatus = status;
    notifyListeners();
  }
}
