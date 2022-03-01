import 'package:activa_efectiva_bus/data/model/response/route_model.dart';
import 'package:activa_efectiva_bus/data/repository/route_repo.dart';
import 'package:flutter/material.dart';

class RouteProvider with ChangeNotifier {
  final RouteRepo routeRepo;

  RouteProvider({@required this.routeRepo});

  List<RouteModel> _operatorRoutes;
  List<RouteModel> get operatorRoutes => _operatorRoutes;

  RouteModel _selectedRoute;
  RouteModel get selectedRoute => _selectedRoute;

  Future<void> getOperatorRoutes(String operatorId) async {
    try {
      final data = await routeRepo.getAllOperatorRoutes(operatorId);
      _operatorRoutes = data;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  // Fetch only local data
  void getAllOperatorRoutesHive() {
    _operatorRoutes =
        routeRepo.getOperatorRoutesHive().values.toList().cast<RouteModel>();
    notifyListeners();
  }

  // Save routeID on preferences then filter on local DB records the matching route
  Future<void> setSelectedRoute() async {
    try {
      final data = routeRepo.getOneOperatorRoute();
      _selectedRoute = data;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> saveSelectedRouteID(String routeID) async {
    try {
      await routeRepo.saveSelectedRoute(routeID);
    } catch (e) {
      throw e;
    }
  }
}
