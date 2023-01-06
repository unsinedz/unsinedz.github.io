import 'dart:async';

import 'package:albion_prices_ui/models/trade_suggestion.dart';
import 'package:albion_prices_ui/services/order_service.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class OrderStore {
  final OrderService _orderService = getIt.get<OrderService>();

  final StreamController<List<TradeSuggestion>> _tradeSuggestions$ =
      StreamController<List<TradeSuggestion>>();

  Stream<List<TradeSuggestion>> get tradeSuggestions =>
      _tradeSuggestions$.stream;

  void getOrders() {
    _orderService.getTradeSuggestions().then((response) {
      _tradeSuggestions$.add(response.tradeSuggestions);
    });
  }
}
