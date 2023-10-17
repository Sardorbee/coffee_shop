import 'package:coffee_shop/bloc/order_bloc/order_bloc.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/data/models/order_coffee_model.dart';
import 'package:coffee_shop/ui/route/route.dart';
import 'package:coffee_shop/ui/widgets/custom_small_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key, required this.coffees});
  final List<CoffeeModel> coffees;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.9),
        itemCount: coffees.length,
        itemBuilder: (context, index) {
          CoffeeModel coffee = coffees[index];
          return Padding(
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 8, bottom: 8),
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                context.go(RouteNames.detailsScreenClient, extra: coffee);
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withOpacity(0.1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(
                      coffee.imageUrl,
                      width: width * 0.25,
                      height: width * 0.25,
                    ),
                    Flexible(
                      child: Text(
                        coffee.name,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: width * 0.25,
                      height: height * 0.05,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$ ${coffee.price}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16),
                          ),
                          CustomSmallButton(
                            iconData: Icons.add,
                            onTap: () {
                              context.read<OrderBloc>().add(AddOrderDraftEvent(
                                      coffeeModel: OrderCoffeeModel(
                                    name: coffee.name,
                                    type: coffee.type,
                                    price: coffee.price,
                                    count: 1,
                                    imageUrl: coffee.imageUrl,
                                  )));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
