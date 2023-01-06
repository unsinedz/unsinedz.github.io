import 'package:json_annotation/json_annotation.dart';

part 'order.g.dart';

@JsonSerializable()
class Order {
  const Order({
    required this.location,
    required this.quality,
    required this.price,
  });

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  Map<String, dynamic> toJson() => _$OrderToJson(this);

  @JsonKey(name: 'Location')
  final String location;

  @JsonKey(name: 'Quality')
  final String quality;

  @JsonKey(name: 'UnitPriceSilver')
  final int price;
}
