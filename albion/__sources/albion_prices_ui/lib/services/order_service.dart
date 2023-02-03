import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import 'models/orders_response.dart';

part 'order_service.g.dart';

@RestApi(baseUrl: 'https://albion-private-prices.zosimovy.ch')
abstract class OrderService {
  factory OrderService(Dio dio, {String? baseUrl}) =>
      _OrderService(dio, baseUrl: baseUrl);

  @GET('/orders')
  Future<OrdersResponse> getTradeSuggestions(
      @Query("income_threshold_percent") int? minimumProfitPercent);
}
