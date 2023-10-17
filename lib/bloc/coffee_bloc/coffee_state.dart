part of 'coffee_bloc.dart';

class CoffeeState {
  final CoffeeModel coffeeModel;
  final FormStatus formStatus;

  CoffeeState({
    required this.coffeeModel,
    required this.formStatus,
  });

  CoffeeState copyWith({
    CoffeeModel? coffeeModel,
    FormStatus? formStatus,
  }) {
    return CoffeeState(
      coffeeModel: coffeeModel ?? this.coffeeModel,
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  String toString() {
    return '''
    CoffeeState{
    coffeeModel: $coffeeModel,
    formStatus: $formStatus
    }''';
  }
}
