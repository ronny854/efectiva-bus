import 'package:activa_efectiva_bus/api/route.dart';
import 'package:activa_efectiva_bus/data/model/response/route_model.dart';
import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class RouteRepo {
  final ApiRoute api;
  final SharedPreferences sharedPreferences;

  RouteRepo({@required this.api, @required this.sharedPreferences});

  // Our local DB
  Box<RouteModel> getOperatorRoutesHive() => Hive.box<RouteModel>('routes');

  // Looks if existing data is already stored locally and retrieved it, otherwise request data from server
  Future<List<RouteModel>> getAllOperatorRoutes(String operatorId) async {
    try {
      final localData = getOperatorRoutesHive();

      if (localData.values.length > 0) {
        return localData.values.toList().cast<RouteModel>();
      }

      final remoteData = await this.api.getOperatorRoutes(operatorId);
      remoteData.forEach((route) => localData.put(route.id, route));

      return remoteData;
    } catch (e) {
      throw e;
    }
  }

  // Get data related for specific route
  RouteModel getOneOperatorRoute() {
    try {
      String routeID = this.getCurrentRouteID();

      if (routeID == "") {
        return null;
      }

      final routes = getOperatorRoutesHive()
          .values
          .where((route) => route.id == routeID)
          .toList();

      if(routes.length == 0 || routes == null){
        return null;
      }

      return routes[0];
    } catch (e) {
      throw e;
    }
  }

  // We save on preferences the current ID to later filter it with db local
  Future<void> saveSelectedRoute(String routeID) async {
    try {
      await sharedPreferences.setString(AppConstants.CURRENT_ROUTE, routeID);
    } catch (e) {
      throw e;
    }
  }

  String getCurrentRouteID() {
    return sharedPreferences.getString(AppConstants.CURRENT_ROUTE) ?? "";
  }

  Future<bool> cleanSelectedRoute() async {
    await sharedPreferences.remove(AppConstants.CURRENT_ROUTE);
    return true;
  }
}
