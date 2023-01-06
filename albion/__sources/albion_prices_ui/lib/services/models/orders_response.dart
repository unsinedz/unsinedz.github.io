import 'package:albion_prices_ui/models/trade_suggestion.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_response.g.dart';

@JsonSerializable()
class OrdersResponse {
  const OrdersResponse({required this.tradeSuggestions});

  factory OrdersResponse.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseToJson(this);

  @JsonKey(name: 'tradeCandidates')
  final List<TradeSuggestion> tradeSuggestions;
}
