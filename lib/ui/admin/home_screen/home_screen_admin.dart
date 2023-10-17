import 'package:coffee_shop/data/local/storage_repo.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/data/repositories/coffee_repo.dart';
import 'package:coffee_shop/ui/admin/home_screen/widgets/custom_listtile.dart';
import 'package:coffee_shop/ui/route/route.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreenAdmin extends StatelessWidget {
  const HomeScreenAdmin({super.key});

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
        title: const Text('Admin Screen'),
        centerTitle: true,
        backgroundColor: AppColors.primaryBg,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(RouteNames.addCoffeeScreenAdmin);
        },
        backgroundColor: AppColors.buttonColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16), // Adjust the radius to control the shape
          ),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.primaryBg,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<CoffeeModel>>(
              stream: context.read<CoffeeRepo>().getProducts(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<CoffeeModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox();
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  List<CoffeeModel>? products = snapshot.data;
                  if (products != null && products.isNotEmpty) {
                    return ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        ...List.generate(
                          products.length,
                          (index) =>
                              ListTileCustom(coffeeModel: products[index]),
                        ),
                      ],
                    );
                  } else if (products == null && products!.isEmpty) {
                    return const Center(
                      child: Text("You have no coffees yet!"),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
