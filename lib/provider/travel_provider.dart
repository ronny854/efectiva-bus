import 'package:flutter/material.dart';

class TravelProvider extends ChangeNotifier {
  bool _showCard = false;
  bool get showCard => _showCard;

  bool _isExecutingCharge = false;
  bool get isExecutingCharge => _isExecutingCharge;

  void showCardInformation(bool showCard) {
    _showCard = showCard;

    notifyListeners();
  }

  void setIsExecutingCharge(bool isExecutingCharge) {
    _isExecutingCharge = isExecutingCharge;

    notifyListeners();
  }
}
