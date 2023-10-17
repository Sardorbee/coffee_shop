part of 'coffee_bloc.dart';

@immutable
abstract class CoffeeEvent {}

class UpdateCoffeeField extends CoffeeEvent {
  final CoffeeFields fieldKey;
  final dynamic value;

  UpdateCoffeeField({
    required this.value,
    required this.fieldKey,
  });
}

class AddCoffeeEvent extends CoffeeEvent {}

class UpdateCoffeeEvent extends CoffeeEvent {}

class DeleteCoffeeEvent extends CoffeeEvent {
  final String coffeeId;

  DeleteCoffeeEvent({
    required this.coffeeId,
  });
}
