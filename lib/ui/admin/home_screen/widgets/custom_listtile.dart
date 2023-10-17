import 'package:coffee_shop/bloc/coffee_bloc/coffee_bloc.dart';
import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:coffee_shop/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListTileCustom extends StatelessWidget {
  const ListTileCustom({super.key, required this.coffeeModel});
  final CoffeeModel coffeeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(12),
          decoration: ShapeDecoration(
            color: AppColors.itemColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 72,
                    height: 72,
                    decoration: ShapeDecoration(
                      image: DecorationImage(
                        image: NetworkImage(coffeeModel.imageUrl),
                        fit: BoxFit.cover,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        coffeeModel.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Rosarivo',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        coffeeModel.type,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Rosarivo',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Text(
                        '\$ ${coffeeModel.price.toString()}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Open Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  // IconButton(
                  //   onPressed: () {},
                  //   icon: const Icon(
                  //     Icons.edit,
                  //     color: AppColors.buttonColor,
                  //   ),
                  // ),
                  IconButton(
                    onPressed: () {
                      context.read<CoffeeBloc>().add(
                          DeleteCoffeeEvent(coffeeId: coffeeModel.coffeeId));
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
