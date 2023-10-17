import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/data/repositories/coffee_repo.dart';
import 'package:coffee_shop/ui/client/homescreen/widget/custom_grid.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenClient extends StatefulWidget {
  const HomeScreenClient({super.key});

  @override
  State<HomeScreenClient> createState() => _HomeScreenClientState();
}

class _HomeScreenClientState extends State<HomeScreenClient> {
  String x = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.primaryBg,
        title: const Text(
          "Coffee Shop",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                setState(() {
                  x = value;
                });
              },
              // controller: searchController,
              decoration: const InputDecoration(
                hintStyle: TextStyle(color: Colors.white30),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white30,
                ),
                fillColor: AppColors.searchColor,
                filled: true,
                hintText: "Browse your favorite coffee...",
              ),
            ),
          ),
          StreamBuilder<List<CoffeeModel>>(
            stream: x.isEmpty
                ? context.read<CoffeeRepo>().getProducts()
                : context.read<CoffeeRepo>().searchProducts(x),
            builder: (BuildContext context,
                AsyncSnapshot<List<CoffeeModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              } else if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              } else {
                List<CoffeeModel>? products = snapshot.data;
                if (products != null && products.isNotEmpty) {
                  return CustomGridView(coffees: products);
                } else if (products == null && products!.isEmpty) {
                  return const Center(
                    child: Text("You have no coffees yet!"),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            },
          )
        ],
      ),
    );
  }
}
