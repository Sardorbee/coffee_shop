import 'package:coffee_shop/data/models/order_coffee_model.dart';

class OrderModel {
  final String orderId;
  final List<OrderCoffeeModel> coffeeModels;
  final String phoneNumber;
  final String destination;
  final double deliveryFee;
  final double tax;
  final double totalPrice;

  OrderModel({
    required this.orderId,
    required this.coffeeModels,
    required this.phoneNumber,
    required this.destination,
    required this.deliveryFee,
    required this.tax,
    required this.totalPrice,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> coffeeModelsJson = json['coffeeModels'];
    List<OrderCoffeeModel> coffeeModels = coffeeModelsJson
        .map((coffeeModelJson) => OrderCoffeeModel.fromMap(coffeeModelJson))
        .toList();

    return OrderModel(
      orderId: json['orderId'],
      coffeeModels: coffeeModels,
      phoneNumber: json['phoneNumber'],
      destination: json['destination'],
      deliveryFee: json['deliveryFee'].toDouble(),
      tax: json['tax'].toDouble(),
      totalPrice: json['totalPrice'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> coffeeModelsJson =
        coffeeModels.map((coffeeModel) => coffeeModel.toMap()).toList();

    return {
      'orderId': orderId,
      'coffeeModels': coffeeModelsJson,
      'phoneNumber': phoneNumber,
      'destination': destination,
      'deliveryFee': deliveryFee,
      'tax': tax,
      'totalPrice': totalPrice,
    };
  }

  OrderModel copyWith({
    String? orderId,
    List<OrderCoffeeModel>? coffeeModels,
    String? phoneNumber,
    String? destination,
    double? deliveryFee,
    double? tax,
    double? totalPrice,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      coffeeModels: coffeeModels ?? this.coffeeModels,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      destination: destination ?? this.destination,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }
}
