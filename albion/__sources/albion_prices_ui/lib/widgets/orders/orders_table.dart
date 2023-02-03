import 'package:albion_prices_ui/widgets/prices/prices_table.dart';
import 'package:albion_prices_ui/widgets/store/order_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'row_builders.dart';

final getIt = GetIt.instance;

enum OrderColumnKey {
  name,
  enchantment,
  quality,
  sellLocation,
  sellPrice,
  buyLocation,
  buyPrice,
  profit,
  profitPercent,
}

class OrdersTable extends StatelessWidget {
  OrdersTable({super.key});

  final OrderStore store = getIt.get<OrderStore>();

  final List<ColumnDescription<OrderColumnKey>> columnNames = const [
    ColumnDescription(title: 'Name', key: OrderColumnKey.name),
    ColumnDescription(title: 'Enchantment', key: OrderColumnKey.enchantment),
    ColumnDescription(title: 'Quality', key: OrderColumnKey.quality),
    ColumnDescription(title: 'Sell location', key: OrderColumnKey.sellLocation),
    ColumnDescription(title: 'Sell price', key: OrderColumnKey.sellPrice),
    ColumnDescription(title: 'Buy location', key: OrderColumnKey.buyLocation),
    ColumnDescription(title: 'Buy price', key: OrderColumnKey.buyPrice),
    ColumnDescription(title: 'Profit per sell', key: OrderColumnKey.profit),
    ColumnDescription(title: 'Profit %', key: OrderColumnKey.profitPercent),
  ];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: store.tradeSuggestions,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('An error occurred. Details: ${snapshot.error}');
        }

        final tradeSuggestions = snapshot.data ?? [];
        final rows = tradeSuggestions
            .map((trade) =>
                trade.orders.map((x) => BuyOrderRowBuilder(trade, x)))
            .fold(
          <RowBuilder>[],
          (previousValue, element) => previousValue..addAll(element),
        ).toList();
        if (rows.isEmpty) {
          return const Text('No data is available. Press "Refresh" to start.');
        }

        return PricesTable<OrderColumnKey>(
          columns: columnNames,
          rows: rows,
        );
      },
    );
  }
}
