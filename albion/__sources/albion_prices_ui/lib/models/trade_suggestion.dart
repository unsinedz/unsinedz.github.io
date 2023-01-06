import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'trade_suggestion.g.dart';

@JsonSerializable()
class TradeSuggestion {
  const TradeSuggestion({
    required this.itemId,
    required this.sellPrice,
    required this.orders,
  });

  factory TradeSuggestion.fromJson(Map<String, dynamic> json) =>
      _$TradeSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$TradeSuggestionToJson(this);

  final String itemId;
  final int sellPrice;

  @JsonKey(name: 'buyOrders')
  final List<Order> orders;
}
