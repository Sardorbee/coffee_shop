part of 'order_bloc.dart';

abstract class OrderEvent {}

class AddOrderEvent extends OrderEvent {}

class UpdateOrderEvent extends OrderEvent {}

class DeleteOrderEvent extends OrderEvent {
  final String orderId;

  DeleteOrderEvent({
    required this.orderId,
  });
}

class AddOrderDraftEvent extends OrderEvent {
  final OrderCoffeeModel coffeeModel;
  AddOrderDraftEvent({
    required this.coffeeModel,
  });
}

class RemoveOrderDraftEvent extends OrderEvent {
  final OrderCoffeeModel coffeeModel;

  RemoveOrderDraftEvent({
    required this.coffeeModel,
  });
}
