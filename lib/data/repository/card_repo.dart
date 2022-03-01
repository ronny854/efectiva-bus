import 'package:activa_efectiva_bus/api/card.dart';
import 'package:activa_efectiva_bus/data/model/body/charge_request_model.dart';
import 'package:activa_efectiva_bus/data/model/response/card_model.dart';
import 'package:activa_efectiva_bus/data/model/response/card_transaction_model.dart';
import 'package:activa_efectiva_bus/data/model/response/charge_model.dart';
import 'package:activa_efectiva_bus/data/model/response/stat_model.dart';

class CardRepo {
  final ApiCard api;
  CardRepo({this.api});

  Future<CardModel> getCardByCode(String code) async {
    try {
      return this.api.getCardByCode(code);
    } catch (e) {
      throw e;
    }
  }

  Future<List<CardTransaction>> getLastCardChargedTransactions(String code, String sourceId) async {
    try {
      return this.api.getLastCardChargedTransactions(code, sourceId);
    } catch (e) {
      throw e;
    }
  }


  Future<ChargeResponseModel> chargeCard(ChargeRequestModel payload) async {
    try {
      return this.api.chargeCard(payload);
    } catch (e) {
      throw e;
    }
  }


  Future<bool> addBalance(String busId, String cardId, num amount) async {
    try {
      return this.api.addBalance(busId, cardId, amount);
    } catch (e) {
      throw e;
    }
  }

  Future<StatModel> getStats(String busId, String from, String to, String frecuency) async {
    try {
      return this.api.getStats(busId, from, to, frecuency);
    } catch (e) {
      throw e;
    }
  }



  Future<bool> deleteTransaction(String transactionId) async {
    try {
      return this.api.deleteTransaction(transactionId);
    } catch (e) {
      throw e;
    }
  }

}
