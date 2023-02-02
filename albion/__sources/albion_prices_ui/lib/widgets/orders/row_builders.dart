import 'package:albion_prices_ui/widgets/prices/prices_table.dart';
import 'package:flutter/material.dart';

import '../../models/order.dart';
import '../../models/trade_suggestion.dart';
import 'orders_table.dart';

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
