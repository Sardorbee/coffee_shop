import 'package:coffee_shop/data/local/storage_repo.dart';
import 'package:coffee_shop/data/models/order_model.dart';
import 'package:coffee_shop/data/repositories/order_repo.dart';
import 'package:coffee_shop/ui/admin/order_screen/widgets/custom_order_listtile.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                StorageRepository.deleteString("isAdmin");
                context.go('/');
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Order Screen'),
        centerTitle: true,
        backgroundColor: AppColors.primaryBg,
        elevation: 0,
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: context.read<OrderRepo>().getOrders(),
        builder:
            (BuildContext context, AsyncSnapshot<List<OrderModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox();
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            List<OrderModel>? orders = snapshot.data;
            if (orders != null && orders.isNotEmpty) {
              return ListView(

                physics: const BouncingScrollPhysics(),
                children: [
                  ...List.generate(
                    orders.length,
                    (index) =>
                        OrderListTileCustom(coffeeModel: orders[index]),
                  ),
                ],
              );
            } else if (orders == null && orders!.isEmpty) {
              return const Center(
                child: Text("You have no coffees yet!"),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }
        },
      ),
    );
  }
}
