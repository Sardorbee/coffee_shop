import 'package:coffee_shop/bloc/order_bloc/order_bloc.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/data/models/order_coffee_model.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CoffeeDetailScreen extends StatelessWidget {
  const CoffeeDetailScreen({super.key, required this.coffeeModel});
  final CoffeeModel coffeeModel;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(coffeeModel.imageUrl)),
                  Text(
                    coffeeModel.type,
                    style:
                        GoogleFonts.rosarivo(fontSize: 24, color: Colors.white),
                  ),
                  Text(
                    coffeeModel.name,
                    style:
                        GoogleFonts.rosarivo(fontSize: 16, color: Colors.white),
                  ),
                  Flexible(
                      child: Text(
                    coffeeModel.description,
                    style:
                        GoogleFonts.openSans(fontSize: 14, color: Colors.white),
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${coffeeModel.price}",
                        style: GoogleFonts.openSans(
                            fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(
                        height: height * 0.06,
                        width: width * 0.5,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor),
                          onPressed: () {
                            context.read<OrderBloc>().add(AddOrderDraftEvent(
                                    coffeeModel: OrderCoffeeModel(
                                  name: coffeeModel.name,
                                  type: coffeeModel.type,
                                  price: coffeeModel.price,
                                  count: 1,
                                  imageUrl: coffeeModel.imageUrl,
                                )));
                          },
                          child: Text(
                            "Add to cart",
                            style: GoogleFonts.openSans(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              top: width * 0.05,
              left: width * 0.05,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  color: Colors.white.withOpacity(0.1),
                ),
                child: IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    size: 35,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
