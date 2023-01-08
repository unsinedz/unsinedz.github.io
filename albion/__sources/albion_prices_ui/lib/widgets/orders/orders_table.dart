import 'package:albion_prices_ui/models/order.dart';
import 'package:albion_prices_ui/models/trade_suggestion.dart';
import 'package:albion_prices_ui/widgets/prices/prices_table.dart';
import 'package:albion_prices_ui/widgets/store/order_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

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
          return const Text('Press "Refresh" to start');
        }

        final tradeSuggestions = snapshot.data ?? [];
        final rows = tradeSuggestions
            .map((trade) =>
                trade.orders.map((x) => BuyOrderRowBuilder(trade, x)))
            .fold(
          <RowBuilder>[],
          (previousValue, element) => previousValue..addAll(element),
        ).toList();
        return PricesTable<OrderColumnKey>(
          columns: columnNames,
          rows: rows,
        );
      },
    );
  }
}

class BuyOrderRowBuilder extends OrderRowBuilder {
  BuyOrderRowBuilder(TradeSuggestion trade, Order order) {
    fields[OrderColumnKey.name] = trade.title;
    fields[OrderColumnKey.enchantment] = '${trade.tier}.${order.enchantment}';
    fields[OrderColumnKey.quality] = order.quality;
    fields[OrderColumnKey.sellLocation] = 'Black Market';
    fields[OrderColumnKey.sellPrice] = trade.sellPrice;
    fields[OrderColumnKey.buyLocation] = order.location;
    fields[OrderColumnKey.buyPrice] = order.price;
    fields[OrderColumnKey.profit] = trade.sellPrice - order.price;
    fields[OrderColumnKey.profitPercent] =
        (trade.sellPrice - order.price) * 100 ~/ order.price;
  }
}

class OrderRowBuilder extends RowBuilder<OrderColumnKey> {
  OrderRowBuilder({
    this.rowBackgroundColor = Colors.white,
    this.cellTextStyle,
  });

  final Color rowBackgroundColor;
  final TextStyle? cellTextStyle;

  @override
  List<DataRow> build(List<ColumnDescription<OrderColumnKey>> columnNames) {
    return [
      DataRow(
        cells: columnNames.map((e) => buildCell(e.key)).toList(),
        color: MaterialStateColor.resolveWith((states) => rowBackgroundColor),
      )
    ];
  }

  DataCell buildCell(OrderColumnKey key) {
    final value = fields[key];
    return DataCell(
      CellContent(text: value!.toString(), textStyle: cellTextStyle),
    );
  }
}
