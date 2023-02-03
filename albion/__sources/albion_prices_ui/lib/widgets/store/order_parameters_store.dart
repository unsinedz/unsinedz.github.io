import 'package:flutter/foundation.dart';

class OrderParametersStore extends ChangeNotifier {
  int? _minimumProfitPercent = 20;

  int? get minimumProfitPercent => _minimumProfitPercent;

  set minimumProfitPercent(int? minimumProfitPercent) {
    _minimumProfitPercent = minimumProfitPercent;
    notifyListeners();
  }
}
