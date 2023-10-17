import 'package:coffee_shop/bloc/order_bloc/order_bloc.dart';
import 'package:coffee_shop/ui/admin/order_screen/widgets/order_listtile.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String destination = "";
  String phoneNumber = "";
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        title: Text(
          'Cart',
          style: GoogleFonts.rosarivo(fontSize: 24, color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: AppColors.primaryBg,
        elevation: 0,
      ),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              ...List.generate(
                state.orderModel.coffeeModels.length,
                (index) => OrderListTile(
                  orderCoffeeModel: state.orderModel.coffeeModels[index],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Charges",
                    style:
                        GoogleFonts.rosarivo(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    "\$${state.deliveryFee}",
                    style:
                        GoogleFonts.rosarivo(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Taxes",
                    style:
                        GoogleFonts.rosarivo(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    "\$${state.tax}",
                    style:
                        GoogleFonts.rosarivo(fontSize: 14, color: Colors.white),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style:
                        GoogleFonts.rosarivo(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    "\$${state.totalPrice}",
                    style:
                        GoogleFonts.rosarivo(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
              TextField(
                controller: controller1,
                style: GoogleFonts.rosarivo(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.itemColor,
                    labelText: 'Destination',
                    labelStyle: GoogleFonts.rosarivo(
                        fontSize: 14, color: Colors.white)),
              ),
              TextField(
                controller: controller2,
                style: GoogleFonts.rosarivo(fontSize: 20, color: Colors.white),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.itemColor,
                    labelText: 'Phone Number',
                    labelStyle: GoogleFonts.rosarivo(
                        fontSize: 14, color: Colors.white)),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonColor,
                  ),
                  onPressed: () {
                    if (state.orderModel.coffeeModels.isNotEmpty &&
                        controller1.text.isNotEmpty &&
                        controller2.text.isNotEmpty) {
                      context
                          .read<OrderBloc>()
                          .processOrder(controller1.text, controller2.text);
                      context.read<OrderBloc>().add(AddOrderEvent());
                      controller1.clear();
                      controller2.clear();
                      context.read<OrderBloc>().clear();
                    }else{
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("You should enter all fields"),
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 2)),
                      );

                    }
                  },
                  child: Text(
                    "ORDER NOW",
                    style: GoogleFonts.openSans(color: AppColors.primaryBg),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
