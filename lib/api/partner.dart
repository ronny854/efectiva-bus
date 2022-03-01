import 'dart:async';

import 'package:activa_efectiva_bus/api/endpoints.dart';
import 'package:activa_efectiva_bus/api/http_client.dart';
import 'package:activa_efectiva_bus/data/model/response/partner_information_model.dart';
import 'package:flutter/cupertino.dart';

abstract class IApiPartner {
  Future<List<PartnerInformationResponse>> getPartnerInformation(String partnerID);
}

class ApiPartner implements IApiPartner {
  final HttpClient http;

  ApiPartner({@required this.http});

  // The information will be retrieved by the id encoded on token
  // TODO: Maybe we should find other way because driver login may be affected
  Future<List<PartnerInformationResponse>> getPartnerInformation(
      String partnerID) async {
    try {
      final res =
          await http.get(Endpoints.getPartnerInformation + "/" + partnerID);
      return List<PartnerInformationResponse>.from(
          res["data"].map((i) => PartnerInformationResponse.fromJson(i)));
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
