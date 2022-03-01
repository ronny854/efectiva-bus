import 'package:activa_efectiva_bus/data/model/response/driver_model.dart';
import 'package:activa_efectiva_bus/data/repository/driver_repo.dart';
import 'package:flutter/material.dart';

class DriverProvider with ChangeNotifier {
  final DriverRepo driverRepo;

  DriverProvider({@required this.driverRepo});

  DriverModel _driverInformation;
  DriverModel get driverInformation => _driverInformation;

  Future<void> getDriverInformation(
      String busId, String operatorId, String pin) async {
    try {
      final data =
          await driverRepo.getDriverInformation(busId, operatorId, pin);
      await driverRepo.saveSelectedDriver(data);

      _driverInformation = data;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void getCurrentDriver() {
    DriverModel driver = driverRepo.getCurrentDriver();
    _driverInformation = driver;
    notifyListeners();
  }


  void resetDriver() {
    _driverInformation = null;
    notifyListeners();
  }
}
