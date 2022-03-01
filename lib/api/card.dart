import 'dart:async';

import 'package:activa_efectiva_bus/api/endpoints.dart';
import 'package:activa_efectiva_bus/api/exceptions/network_exceptions.dart';
import 'package:activa_efectiva_bus/api/http_client.dart';
import 'package:activa_efectiva_bus/data/model/body/charge_request_model.dart';
import 'package:activa_efectiva_bus/data/model/response/card_model.dart';
import 'package:activa_efectiva_bus/data/model/response/card_transaction_model.dart';
import 'package:activa_efectiva_bus/data/model/response/charge_model.dart';
import 'package:activa_efectiva_bus/data/model/response/stat_model.dart';
import 'package:flutter/cupertino.dart';

abstract class IApiCard {
  Future<CardModel> getCardByCode(String code);
  Future<ChargeResponseModel> chargeCard(ChargeRequestModel payload);
}

class ApiCard implements IApiCard {
  final HttpClient http;

  ApiCard({@required this.http});

  // Gets card information by provided code
  Future<CardModel> getCardByCode(String code) async {
    try {
      final res = await http.get(Endpoints.getCardByCode + "/" + code);

      return CardModel.fromJson(res["data"]);
    } catch (e) {
      print("####### [ApiCard ERROR] -> getCardByCode #######");
      if (e is NetworkException) {
        print(">> NetworkException");
        print(e.message);
      } else {
        print(">> NotHandledException");
        print(e.toString());
      }
      print("##############################");
      throw e;
    }
  }

  // Gets card charged transactions from 10 minute ago
  Future<List<CardTransaction>> getLastCardChargedTransactions(
      String code, String sourceId) async {
    try {
      final res = await http.get(Endpoints.getLastCardChargedTransactions +
          "/" +
          code +
          "/" +
          sourceId);

      return List<CardTransaction>.from(
          res["data"].map((i) => CardTransaction.fromJson(i)));
    } catch (e) {
      print(
          "####### [ApiCard ERROR] -> getLastCardChargedTransactions #######");
      if (e is NetworkException) {
        print(">> NetworkException");
        print(e.message);
      } else {
        print(">> NotHandledException");
        print(e.toString());
      }
      print("##############################");
      throw e;
    }
  }

  // Execute a charge transaction
  Future<ChargeResponseModel> chargeCard(ChargeRequestModel payload) async {
    try {
      final res = await http.post(Endpoints.executeCharge, body: {
        "code": payload.code,
        "operatorId": payload.operatorId,
        "busId": payload.busId,
        "routeId": payload.routeId,
        "amount": payload.amountToDebit
      });

      return ChargeResponseModel.fromJson(res["data"]);
    } catch (e) {
      print("#######  [ApiCard ERROR] -> chargeCard #######");
      if (e is NetworkException) {
        print(">> NetworkException");
        print(e.message);
      } else {
        print(">> NotHandledException");
        print(e.toString());
      }
      print("##############################");
      throw e;
    }
  }

  // Add card balance
  Future<bool> addBalance(String busId, String cardId, num amount) async {
    try {
      await http.post(Endpoints.addBalance, body: {
        "storeId": busId,
        "code": cardId,
        "amount": amount,
      });
      return true;
    } catch (e) {
      print("####### [ApiCard ERROR] -> addBalance #######");
      if (e is NetworkException) {
        print(">> NetworkException");
        print(e.message);
      } else {
        print(">> NotHandledException");
        print(e.toString());
      }
      print("##############################");
      throw e;
    }
  }

  // Stats
  Future<StatModel> getStats(String busId, String from, String to, String frecuency) async {
    try {
      final res =  await http.post(Endpoints.stats, body: {
        "frecuency": frecuency,
        "busId": busId,
        "from": from,
        "to": to,
      });
      return StatModel.fromJson(res["data"]);
    } catch (e) {
      print("####### [ApiCard ERROR] -> getStats #######");
      if (e is NetworkException) {
        print(">> NetworkException");
        print(e.message);
      } else {
        print(">> NotHandledException");
        print(e.toString());
      }
      print("##############################");
      throw e;
    }
  }

  // Add card balance
  Future<bool> deleteTransaction(String transactionId) async {
    try {
      print(transactionId);
      await http.post(Endpoints.deleteLastTransaction, body: {
        "transactionId": transactionId
      });
      return true;
    } catch (e) {
      print("####### [ApiCard ERROR] -> deleteTransaction #######");
      if (e is NetworkException) {
        print(">> NetworkException");
        print(e.message);
      } else {
        print(">> NotHandledException");
        print(e.toString());
      }
      print("##############################");
      throw e;
    }
  }
}
