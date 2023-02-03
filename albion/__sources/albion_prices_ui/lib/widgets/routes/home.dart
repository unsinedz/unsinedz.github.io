import 'package:albion_prices_ui/widgets/orders/orders_table.dart';
import 'package:albion_prices_ui/widgets/orders/profit_filter.dart';
import 'package:albion_prices_ui/widgets/store/order_parameters_store.dart';
import 'package:albion_prices_ui/widgets/store/order_store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final OrderParametersStore orderParameters =
      getIt.get<OrderParametersStore>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albion Private Prices'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 12),
                ProfitFilter(
                  onChanged: (value) =>
                      orderParameters.minimumProfitPercent = value,
                ),
                ButtonRow(),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: OrdersTable(),
                ),
              ],
            ),
          ),
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: SizedBox(
        width: 100,
        height: 30,
        child: ElevatedButton(
          onPressed: onStart,
          child: const Text("Refresh"),
        ),
      ),
    );
  }

  void onStart() {
    store.getOrders();
  }
}
