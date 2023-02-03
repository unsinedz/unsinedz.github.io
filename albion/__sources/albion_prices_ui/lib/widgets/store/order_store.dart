import 'dart:async';

import 'package:albion_prices_ui/models/trade_suggestion.dart';
import 'package:albion_prices_ui/services/order_service.dart';
import 'package:get_it/get_it.dart';

import 'order_parameters_store.dart';

final getIt = GetIt.instance;

class OrderStore {
  final OrderService _orderService = getIt.get<OrderService>();
  final OrderParametersStore _orderParameters =
      getIt.get<OrderParametersStore>();

  final StreamController<List<TradeSuggestion>> _tradeSuggestions$ =
      StreamController<List<TradeSuggestion>>();

  Stream<List<TradeSuggestion>> get tradeSuggestions =>
      _tradeSuggestions$.stream;

  void getOrders() {
    _orderService
        .getTradeSuggestions(_orderParameters.minimumProfitPercent)
        .then((response) {
      _tradeSuggestions$.add(response.tradeSuggestions);
    });
  }
}
