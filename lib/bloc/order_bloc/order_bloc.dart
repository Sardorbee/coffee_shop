import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_shop/data/models/form_status.dart';
import 'package:coffee_shop/data/models/order_coffee_model.dart';
import 'package:coffee_shop/data/models/order_model.dart';
import 'package:coffee_shop/data/repositories/order_repo.dart';
import 'package:equatable/equatable.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrderRepo orderRepo = OrderRepo();
  OrderBloc()
      : super(
          OrderState(
            destination: '',
            phoneNumber: '',
            deliveryFee: 0,
            tax: 0,
            totalPrice: 0,
            formStatus: FormStatus.pure,
            orderModel: OrderModel(
              orderId: '',
              coffeeModels: [],
              phoneNumber: '',
              destination: '',
              deliveryFee: 0,
              tax: 0,
              totalPrice: 0,
            ),
          ),
        ) {
    on<AddOrderEvent>(addOrder);
    on<UpdateOrderEvent>(updateOrder);
    on<DeleteOrderEvent>(deleteOrder);
    on<AddOrderDraftEvent>(addOrderDraft);
    on<RemoveOrderDraftEvent>(removeOrderDraft);
  }

  clear() {
    // ignore: invalid_use_of_visible_for_testing_member
    emit(
      OrderState(
        destination: '',
        phoneNumber: '',
        deliveryFee: 0,
        tax: 0,
        totalPrice: 0,
        formStatus: FormStatus.pure,
        orderModel: OrderModel(
          orderId: '',
          coffeeModels: [],
          phoneNumber: '',
          destination: '',
          deliveryFee: 0,
          tax: 0,
          totalPrice: 0,
        ),
      ),
    );
  }

  void processOrder(String destination, String phoneNumber) {
    if (kDebugMode) {
      print(state.toString());
    }
    // ignore: invalid_use_of_visible_for_testing_member
    emit(state.copyWith(phoneNumber: phoneNumber, destination: destination));
  }

  Future<void> addOrder(AddOrderEvent event, Emitter<OrderState> emit) async {
    await orderRepo.addOrder(
        coffeeModel: OrderModel(
            orderId: '',
            coffeeModels: state.orderModel.coffeeModels,
            phoneNumber: state.phoneNumber,
            destination: state.destination,
            deliveryFee: state.deliveryFee,
            tax: state.tax,
            totalPrice: state.totalPrice));
    emit(state.copyWith(formStatus: FormStatus.success));
  }

  Future<void> updateOrder(
      UpdateOrderEvent event, Emitter<OrderState> emit) async {
    await orderRepo.updateOrder(
        coffeeModel: OrderModel(
            orderId: '',
            coffeeModels: state.orderModel.coffeeModels,
            phoneNumber: '',
            destination: '',
            deliveryFee: state.deliveryFee,
            tax: state.tax,
            totalPrice: state.totalPrice));
    emit(state.copyWith(formStatus: FormStatus.success));
  }

  Future<void> deleteOrder(
      DeleteOrderEvent event, Emitter<OrderState> emit) async {
    await orderRepo.deleteOrder(coffeeId: event.orderId);
    emit(state.copyWith(formStatus: FormStatus.success));
  }

  Future<void> addOrderDraft(
      AddOrderDraftEvent event, Emitter<OrderState> emit) async {
    if (!state.orderModel.coffeeModels.contains(event.coffeeModel)) {
      state.orderModel.coffeeModels.add(event.coffeeModel);
    }
    final additionalDeliveryFee =
        event.coffeeModel.price * event.coffeeModel.count * 0.1;
    final additionalTax =
        event.coffeeModel.price * event.coffeeModel.count * 0.05;
    final additionalTotalPrice =
        event.coffeeModel.price * event.coffeeModel.count;

    emit(
      state.copyWith(
        formStatus: FormStatus.success,
        deliveryFee: state.orderModel.deliveryFee + additionalDeliveryFee,
        tax: state.orderModel.tax + additionalTax,
        totalPrice: (state.orderModel.totalPrice + additionalTotalPrice) +
            state.orderModel.tax +
            state.orderModel.deliveryFee,
      ),
    );
  }

  Future<void> removeOrderDraft(
      RemoveOrderDraftEvent event, Emitter<OrderState> emit) async {
    if (state.orderModel.coffeeModels.contains(event.coffeeModel)) {
      state.orderModel.coffeeModels.remove(event.coffeeModel);

      emit(
        state.copyWith(
          formStatus: FormStatus.success,
          deliveryFee: state.orderModel.deliveryFee -
              (event.coffeeModel.price * event.coffeeModel.count) * 0.1,
          tax: state.orderModel.tax -
              (event.coffeeModel.price * event.coffeeModel.count) * 0.05,
          totalPrice: state.orderModel.totalPrice -
              (event.coffeeModel.price * event.coffeeModel.count),
        ),
      );
      emit(
        state.copyWith(
          totalPrice: state.orderModel.totalPrice -
              state.orderModel.tax -
              state.orderModel.deliveryFee,
        ),
      );
    }
  }
}
