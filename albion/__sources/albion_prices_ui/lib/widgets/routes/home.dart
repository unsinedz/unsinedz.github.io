import 'package:albion_prices_ui/widgets/orders/orders_table.dart';
import 'package:albion_prices_ui/widgets/store/order_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albion Private Prices'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            ButtonRow(),
            SizedBox(
              width: double.infinity,
              child: OrdersTable(),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonRow extends StatelessWidget {
  ButtonRow({super.key});

  final OrderStore store = getIt.get<OrderStore>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          width: 100,
          height: 30,
          child: ElevatedButton(
            onPressed: onStart,
            child: const Text("Refresh"),
          ),
        ),
      ),
    );
  }

  void onStart() {
    store.getOrders();
  }
}
