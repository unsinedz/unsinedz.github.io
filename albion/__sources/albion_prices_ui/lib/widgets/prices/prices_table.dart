import 'package:flutter/material.dart';

class ColumnDescription<TKey> {
  const ColumnDescription({
    required this.title,
    required this.key,
    this.isSortable = true,
  });

  final String title;
  final TKey key;
  final bool isSortable;
}

class PricesTable<TColumnKey> extends StatefulWidget {
  const PricesTable({
    super.key,
    required this.columns,
    required this.rows,
  });

  final List<ColumnDescription<TColumnKey>> columns;
  final List<RowBuilder> rows;

  @override
  State<PricesTable<TColumnKey>> createState() =>
      _PricesTableState<TColumnKey>();
}

class _PricesTableState<T> extends State<PricesTable<T>> {
  int? _sortColumnIndex;
  bool _sortAscending = true;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      sortColumnIndex: _sortColumnIndex,
      sortAscending: _sortAscending,
      headingTextStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 16,
        color: Colors.grey,
      ),
      columns: widget.columns.map(buildDataColumn).toList(),
      rows: getOrdersRows().map((e) => e.build(widget.columns)).fold(
          <DataRow>[],
          (previousValue, element) => previousValue..addAll(element)).toList(),
    );
  }

  Iterable<RowBuilder> getOrdersRows() {
    var rows = widget.rows;
    if (_sortColumnIndex != null) {
      final sortField = widget.columns[_sortColumnIndex!].key;
      rows.sort((a, b) =>
          a.fields[sortField]!.compareTo(b.fields[sortField]!) *
          (_sortAscending ? 1 : -1));
    }

    return rows;
  }

  DataColumn buildDataColumn(ColumnDescription columnName) {
    onSort(int columnIndex, bool ascending) {
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    return DataColumn(
      label: ColumnLabel(text: columnName.title),
      onSort: columnName.isSortable ? onSort : null,
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

abstract class RowBuilder<TColumnKey> {
  final Map<TColumnKey, Comparable> fields = <TColumnKey, Comparable>{};

  List<DataRow> build(List<ColumnDescription<TColumnKey>> columnNames);
}
