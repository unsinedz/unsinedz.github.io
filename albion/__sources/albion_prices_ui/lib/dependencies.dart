import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'services/order_service.dart';
import 'widgets/store/order_parameters_store.dart';
import 'widgets/store/order_store.dart';

void registerDependencies({bool isDev = false}) {
  final getIt = GetIt.instance;

  getIt.registerLazySingleton<OrderStore>(() => OrderStore());
  getIt.registerFactory<OrderService>(
    () => OrderService(
      Dio(),
      baseUrl: isDev ? "http://localhost" : null,
    ),
  );
  getIt.registerSingleton(OrderParametersStore());
}
