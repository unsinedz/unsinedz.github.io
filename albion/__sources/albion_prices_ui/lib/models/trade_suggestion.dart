import 'package:json_annotation/json_annotation.dart';

import 'order.dart';

part 'trade_suggestion.g.dart';

@JsonSerializable()
class TradeSuggestion {
  const TradeSuggestion({
    required this.title,
    required this.tier,
    required this.enchantment,
    required this.quality,
    required this.sellPrice,
    required this.orders,
  });

  factory TradeSuggestion.fromJson(Map<String, dynamic> json) =>
      _$TradeSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$TradeSuggestionToJson(this);

  final String title;
  final String tier;
  final int enchantment;
  final String quality;
  final int sellPrice;

  @JsonKey(name: 'buyOrders')
  final List<Order> orders;
}
