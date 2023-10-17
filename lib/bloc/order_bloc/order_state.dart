part of 'order_bloc.dart';

class OrderState extends Equatable {
  final OrderModel orderModel;
  final FormStatus formStatus;
  final double deliveryFee;
  final double tax;
  final double totalPrice;
  final String destination;
  final String phoneNumber;

  const OrderState({
    required this.orderModel,
    required this.formStatus,
    required this.deliveryFee,
    required this.tax,
    required this.totalPrice,
    required this.destination,
    required this.phoneNumber,
  });

  OrderState copyWith({
    OrderModel? orderModel,
    FormStatus? formStatus,
    double? deliveryFee,
    double? tax,
    double? totalPrice,
    String? destination,
    String? phoneNumber,
  }) {
    return OrderState(
      orderModel: orderModel ?? this.orderModel,
      formStatus: formStatus ?? this.formStatus,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      totalPrice: totalPrice ?? this.totalPrice,
      destination: destination ?? this.destination,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
        orderModel,
        formStatus,
        deliveryFee,
        tax,
        totalPrice,
        destination,
        phoneNumber
      ];
}
