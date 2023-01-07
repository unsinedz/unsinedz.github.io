import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  const Order({
    required this.location,
    required this.enchantment,
    required this.quality,
    required this.price,
    required this.amount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @JsonKey(name: 'Location')
  final String location;

  @JsonKey(name: 'EnchantmentLevel')
  final int enchantment;

  @JsonKey(name: 'Quality')
  final String quality;

  @JsonKey(name: 'UnitPriceSilver')
  final int price;

  @JsonKey(name: 'Amount')
  final int amount;
}
