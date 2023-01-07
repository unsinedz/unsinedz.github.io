import 'package:albion_prices_ui/models/order.dart';
import 'package:albion_prices_ui/models/trade_suggestion.dart';
import 'package:albion_prices_ui/widgets/prices/prices_table.dart';
import 'package:albion_prices_ui/widgets/store/order_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class OrdersTable extends StatelessWidget {
  OrdersTable({super.key});

  final OrderStore store = getIt.get<OrderStore>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.tradeSuggestions,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Press "Refresh" to start');
        }

        final tradeSuggestions = snapshot.data ?? [];
        final rows = tradeSuggestions.map(mapTradeSuggestion).fold(
          <DataRow>[],
          (previousValue, element) => previousValue..addAll(element),
        );
        return PricesTable(rows: rows);
      },
    );
  }

  List<DataRow> mapTradeSuggestion(TradeSuggestion trade) {
    return [
      CaptionRowBuilder(
        name: trade.title,
        enchantment: trade.enchantment,
        quality: trade.quality,
        sellPrice: trade.sellPrice,
      ).build(),
      ...trade.orders.map(mapOrder),
    ];
  }

  DataRow mapOrder(Order order) {
    return OrderRowBuilder(
      location: order.location,
      quality: order.quality,
      price: order.price,
      amount: order.amount,
      enchantment: order.enchantment,
    ).build();
  }
}
