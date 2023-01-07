import 'package:flutter/material.dart';

class PricesTable extends StatelessWidget {
  const PricesTable({
    super.key,
    required this.rows,
  });

  final List<DataRow> rows;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingTextStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 16,
      ),
      columns: const [
        DataColumn(label: ColumnLabel(text: 'Name')),
        DataColumn(label: ColumnLabel(text: 'Enchantment')),
        DataColumn(label: ColumnLabel(text: 'Quality')),
        DataColumn(label: ColumnLabel(text: 'Location')),
        DataColumn(label: ColumnLabel(text: 'Price')),
      ],
      rows: rows,
    );
  }
}

class ColumnLabel extends StatelessWidget {
  const ColumnLabel({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(text),
    );
  }
}

class CellContent extends StatelessWidget {
  const CellContent({
    super.key,
    required this.text,
    this.textStyle,
  });

  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle);
  }
}

class OrderRowBuilder {
  const OrderRowBuilder({
    required this.location,
    required this.quality,
    required this.price,
    required this.amount,
    required this.enchantment,
  });

  final int amount;
  final int enchantment;
  final String quality;
  final String location;
  final int price;

  DataRow build() {
    return DataRow(
      color: MaterialStateColor.resolveWith((states) => Colors.grey.shade300),
      cells: [
        DataCell(CellContent(text: 'Amount: $amount')),
        DataCell(CellContent(text: enchantment.toString())),
        DataCell(CellContent(text: quality)),
        DataCell(CellContent(text: location)),
        DataCell(CellContent(text: price.toString())),
      ],
    );
  }
}

class CaptionRowBuilder {
  const CaptionRowBuilder({
    required this.name,
    required this.enchantment,
    required this.quality,
    required this.sellPrice,
  });

  final String name;
  final int enchantment;
  final String quality;
  final int sellPrice;

  final TextStyle textStyle = const TextStyle(fontWeight: FontWeight.w600);

  DataRow build() {
    return DataRow(
      cells: [
        DataCell(CellContent(text: name, textStyle: textStyle)),
        DataCell(
            CellContent(text: enchantment.toString(), textStyle: textStyle)),
        DataCell(CellContent(text: quality.toString(), textStyle: textStyle)),
        DataCell(CellContent(text: '', textStyle: textStyle)),
        DataCell(CellContent(text: sellPrice.toString(), textStyle: textStyle)),
      ],
      color: MaterialStateColor.resolveWith((states) => Colors.green.shade200),
    );
  }
}
