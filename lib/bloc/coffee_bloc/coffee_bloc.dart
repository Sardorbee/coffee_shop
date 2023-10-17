import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_shop/data/models/coffee_fields.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/data/models/form_status.dart';
import 'package:coffee_shop/data/repositories/coffee_repo.dart';
import 'package:flutter/material.dart';

part 'coffee_event.dart';
part 'coffee_state.dart';

class CoffeeBloc extends Bloc<CoffeeEvent, CoffeeState> {
  final CoffeeRepo coffeeRepo = CoffeeRepo();
  CoffeeBloc()
      : super(
          CoffeeState(
            formStatus: FormStatus.pure,
            coffeeModel: CoffeeModel(
                name: '',
                type: '',
                price: 0.0,
                imageUrl: '',
                description: '',
                createdAt: DateTime.now().toString()),
          ),
        ) {
    on<UpdateCoffeeField>(updateCoffeeField);
    on<AddCoffeeEvent>(addCoffee);
    on<UpdateCoffeeEvent>(updateCoffee);
    on<DeleteCoffeeEvent>(deleteCoffee);
  }

  Future<void> addCoffee(
      AddCoffeeEvent event, Emitter<CoffeeState> emit) async {
    await coffeeRepo.addCoffee(coffeeModel: state.coffeeModel);
    emit(state.copyWith(formStatus: FormStatus.success));
  }

  Future<void> updateCoffee(
      UpdateCoffeeEvent event, Emitter<CoffeeState> emit) async {
    await coffeeRepo.updateCoffee(coffeeModel: state.coffeeModel);
    emit(state.copyWith(formStatus: FormStatus.success));
  }

  Future<void> deleteCoffee(
      DeleteCoffeeEvent event, Emitter<CoffeeState> emit) async {
    await coffeeRepo.deleteCoffee(coffeeId: event.coffeeId);
    emit(state.copyWith(formStatus: FormStatus.success));
  }

  void updateCoffeeField(UpdateCoffeeField event, Emitter<CoffeeState> emit) {
    CoffeeModel currentCoffee = state.coffeeModel;

    switch (event.fieldKey) {
      case CoffeeFields.name:
        {
          currentCoffee = currentCoffee.copyWith(name: event.value as String);
          break;
        }
      case CoffeeFields.price:
        {
          currentCoffee = currentCoffee.copyWith(price: event.value as double);
          break;
        }
      case CoffeeFields.imageUrl:
        {
          currentCoffee =
              currentCoffee.copyWith(imageUrl: event.value as String);
          break;
        }
      case CoffeeFields.type:
        {
          currentCoffee = currentCoffee.copyWith(type: event.value as String);
          break;
        }
      case CoffeeFields.description:
        {
          currentCoffee =
              currentCoffee.copyWith(description: event.value as String);
          break;
        }
      case CoffeeFields.createdAt:
        {
          currentCoffee =
              currentCoffee.copyWith(createdAt: event.value as String);
          break;
        }
    }

    debugPrint("Coffee: $currentCoffee");
    currentCoffee =
        currentCoffee.copyWith(createdAt: DateTime.now().toString());
    emit(state.copyWith(coffeeModel: currentCoffee));
  }
}
