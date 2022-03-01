import 'package:activa_efectiva_bus/data/enums/device_action.dart';
import 'package:activa_efectiva_bus/data/model/body/charge_request_model.dart';
import 'package:activa_efectiva_bus/data/model/response/card_model.dart';
import 'package:activa_efectiva_bus/data/model/response/card_transaction_model.dart';
import 'package:activa_efectiva_bus/data/model/response/charge_model.dart';
import 'package:activa_efectiva_bus/data/model/response/stat_model.dart';
import 'package:activa_efectiva_bus/data/repository/card_repo.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class CardProvider with ChangeNotifier {
  final CardRepo cardRepo;

  CardProvider({@required this.cardRepo});

  ChargeResponseModel _chargeInformation;
  ChargeResponseModel get chargeInformation => _chargeInformation;

  bool _successReader = false;
  bool get successReader => _successReader;

  String _validationErrorReader = "";
  String get validationErrorReader => _validationErrorReader;

  // Use when manual amount is entered
  String _amount_to_charge = "";
  String get amount_to_charge => _amount_to_charge;

  // Use when a preconfigured rate was selected
  num _selected_rate_amount = 0;
  num get selected_rate_amount => _selected_rate_amount;

  // Which action is set for device
  DeviceAction _deviceAction = DeviceAction.CHARGE;
  DeviceAction get deviceAction => _deviceAction;

  // Card to use in recharge or refund process
  CardModel _cardReaded;
  CardModel get cardReaded => _cardReaded;

  bool _fetchingCardInfo = false;
  bool get fetchingCardInfo => _fetchingCardInfo;

  bool _isRecharging = false;
  bool get isRecharging => _isRecharging;

  bool _isRefunding = false;
  bool get isRefunding => _isRefunding;

  List<CardTransaction> _lastCardChargedTrxs;
  List<CardTransaction> get lastCardChargedTrxs => _lastCardChargedTrxs;

  Position _currentPosition;
  String _currentAddress = "";
  String get currentAddress => _currentAddress;

  StatModel _stats = StatModel(
      totalPreference: 0,
      totalNoPreference: 0,
      total: 0,
      preferencialAmount: 0,
      noPreferencialAmount: 0,
      rechargesAmount: 0,
      rechargesCount: 0);
  StatModel get stats => _stats;

  Future<bool> getCardByCode(String code) async {
    try {
      if (code.isEmpty) {
        throw "Ingrese el código de la tarjeta";
      }
      final data = await cardRepo.getCardByCode(code);
      _cardReaded = data;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> getLastCardChargedTransactions(
      String code, String sourceId) async {
    try {
      final data =
          await cardRepo.getLastCardChargedTransactions(code, sourceId);
      _lastCardChargedTrxs = data;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<ChargeResponseModel> chargeCard(ChargeRequestModel payload) async {
    try {
      // if we pass 0 and enableManualRates options is enabled in operator then
      // BE will reject our request
      _currentPosition = await determinePosition();
      print('ubicacion => $_currentPosition');
      //_getAddressFromLatLng(_currentPosition);
      payload.amountToDebit = _selected_rate_amount;
      if (_amount_to_charge != null &&
          _amount_to_charge != "" &&
          _amount_to_charge != "null") {
        payload.amountToDebit =
            num.tryParse(_amount_to_charge.replaceAll(",", ".")) * 100;
      }
      final data = await cardRepo.chargeCard(payload);
      
      _chargeInformation = data;
      notifyListeners();
      return data;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> rechargeCard(String busId, String cardId, num amount) async {
    try {
      await cardRepo.addBalance(busId, cardId, amount);

      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> deleteTransaction(String transactionId, int index) async {
    try {
      print(transactionId);
      await cardRepo.deleteTransaction(transactionId);
      _lastCardChargedTrxs.removeAt(index);
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<bool> getStats(
      String busId, String from, String to, String frecuency) async {
    try {
      final data = await cardRepo.getStats(busId, from, to, frecuency);
      _stats = data;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  void setDeviceAction(DeviceAction deviceAction) {
    _deviceAction = deviceAction;
    notifyListeners();
  }

  void setAmountToCharge(String amount) {
    _amount_to_charge = amount;
    if (amount != "") {
      _amount_to_charge = num.tryParse(amount).toString();
    }

    notifyListeners();
  }

  void setSelectedRateAmount(num amount) {
    _selected_rate_amount = amount;
    notifyListeners();
  }

  void setSuccessReader(bool status) {
    _successReader = status;
    notifyListeners();
  }

  void setValidationErrorReader(String error) {
    _validationErrorReader = error;
    notifyListeners();
  }

  void setLastCardChargedTrxs(List<CardTransaction> cards) {
    _lastCardChargedTrxs = cards;
    notifyListeners();
  }

  void setCardReaded(CardModel card) {
    _cardReaded = card;
    notifyListeners();
  }

  void setFetchingCardInfo(bool isFetching) {
    _fetchingCardInfo = isFetching;
    notifyListeners();
  }

  void setIsRecharging(bool status) {
    _isRecharging = status;
    notifyListeners();
  }

  void setIsRefunding(bool status) {
    _isRefunding = status;
    notifyListeners();
  }

  Future<Position> determinePosition() async {
    LocationPermission permission;
    Position retornar;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return retornar;
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse) {
        return retornar;
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromLatLng(Position _position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _position.latitude, _position.longitude);

      Placemark place = placemarks[0];

      _currentAddress =
          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
      //print('Ubicacion => ' + _currentAddress);

      print("ubicacion lista");
    } catch (e) {
      print(e);
    }
  }
}
