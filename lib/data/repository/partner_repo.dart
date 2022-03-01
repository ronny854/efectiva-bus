import 'package:activa_efectiva_bus/api/partner.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/utill/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartnerRepo {
  final ApiPartner api;
  final SharedPreferences sharedPreferences;

  PartnerRepo({@required this.api, @required this.sharedPreferences});

  // Our local DB
  Box<PartnerInformationResponse> getPartnerInformationHive() =>
      Hive.box<PartnerInformationResponse>('partner_information');

  // Get data related for every bus the partner has
  Future<List<PartnerInformationResponse>> getAllPartnerInformation(String partnerID) async {
    try {
      final localData = getPartnerInformationHive();
      if (localData.values.length > 0) {
        return localData.values.toList().cast<PartnerInformationResponse>();
      }

      final remoteData = await this.api.getPartnerInformation(partnerID);
      remoteData.forEach(
          (partnerInfo) => localData.put(partnerInfo.bus.id, partnerInfo));

      return remoteData;
    } catch (e) {
      throw e;
    }
  }

  // Get data related for specific partner has
  PartnerInformationResponse getCurrentPartnerInformation() {
    try {
      String busID = this.getCurrentBusID();
      if (busID == "") {
        return null;
      }

      final partnerInformation = getPartnerInformationHive()
          .values
          .where((partner) => partner.bus.id == busID)
          .toList();

      if(partnerInformation.length == 0 || partnerInformation == null){
        return null;
      }

      return partnerInformation[0];
    } catch (e) {
      throw e;
    }
  }

  // The selected transport unit is the one which is currently being used for connect with proximity reader
  Future<void> saveSelectedTransportUnit(String busId) async {
    try {
      await sharedPreferences.setString(AppConstants.CURRENT_BUS_ID, busId);
    } catch (e) {
      throw e;
    }
  }

  String getCurrentBusID() {
    return sharedPreferences.getString(AppConstants.CURRENT_BUS_ID) ?? "";
  }

  Future<bool> cleanSelectedTransportUnit() async {
    await sharedPreferences.remove(AppConstants.CURRENT_BUS_ID);
    return true;
  }

  // The selected transport unit is the one which is currently being used for connect with proximity reader
  Future<void> saveSelectedOperatorID(String operatorID) async {
    try {
      await sharedPreferences.setString(AppConstants.CURRENT_OPERATOR_ID, operatorID);
    } catch (e) {
      throw e;
    }
  }

  String getOperatorID() {
    return sharedPreferences.getString(AppConstants.CURRENT_OPERATOR_ID) ?? "";
  }

  Future<bool> cleanOperatorUnit() async {
    await sharedPreferences.remove(AppConstants.CURRENT_OPERATOR_ID);
    return true;
  }

  // The selected transport unit is the one which is currently being used for connect with proximity reader
  Future<void> saveSelectedPartnerID(String partnerID) async {
    try {
      await sharedPreferences.setString(AppConstants.CURRENT_PARTNER_ID, partnerID);
    } catch (e) {
      throw e;
    }
  }

  String getPartnerID() {
    return sharedPreferences.getString(AppConstants.CURRENT_PARTNER_ID) ?? "";
  }

  Future<bool> cleanPartnerID() async {
    await sharedPreferences.remove(AppConstants.CURRENT_PARTNER_ID);
    return true;
  }

}
