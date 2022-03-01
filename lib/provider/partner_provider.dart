import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:activa_efectiva_bus/data/repository/partner_repo.dart';
import 'package:flutter/material.dart';

class PartnerProvider with ChangeNotifier {
  final PartnerRepo partnerRepo;

  PartnerProvider({@required this.partnerRepo});

  List<PartnerInformationResponse> _partnerInformation;
  List<PartnerInformationResponse> get partnerInformation =>
      _partnerInformation;

  PartnerInformationResponse _selectedPartnerInformation;
  PartnerInformationResponse get selectedPartnerInformation =>
      _selectedPartnerInformation;

  Future<void> getPartnerInformation(String partnerID) async {
    try {
      final data = await partnerRepo.getAllPartnerInformation(partnerID);
      _partnerInformation = data;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void setSelectedPartnerInformation() {
    try {
      final data = partnerRepo.getCurrentPartnerInformation();
      _selectedPartnerInformation = data;
      notifyListeners();
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> saveSelectedTransportUnit(String busID) async {
    try {
      await partnerRepo.saveSelectedTransportUnit(busID);

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  String getSelectedPartnerID() {
    return partnerRepo.getPartnerID();
  }

  Future<bool> saveSelectedPartnerID(String partnerID) async {
    try {
      await partnerRepo.saveSelectedPartnerID(partnerID);

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }


  String getSelectedBusID() {
    return partnerRepo.getCurrentBusID();
  }

  Future<bool> saveSelectedOperatorID(String operatorID) async {
    try {
      await partnerRepo.saveSelectedOperatorID(operatorID);

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  String getSelectedOperatorID() {
    return partnerRepo.getOperatorID();
  }
}
