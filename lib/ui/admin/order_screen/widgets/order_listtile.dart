import 'package:coffee_shop/bloc/order_bloc/order_bloc.dart';
import 'package:coffee_shop/data/models/order_coffee_model.dart';
import 'package:coffee_shop/ui/widgets/custom_small_button.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderListTile extends StatefulWidget {
  const OrderListTile({super.key, required this.orderCoffeeModel});
  final OrderCoffeeModel orderCoffeeModel;

  @override
  State<OrderListTile> createState() => _OrderListTileState();
}

class _OrderListTileState extends State<OrderListTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        context.read<OrderBloc>().add(
            RemoveOrderDraftEvent(coffeeModel: widget.orderCoffeeModel));
      },
      child: Container(
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
                      image: NetworkImage(widget.orderCoffeeModel.imageUrl),
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
                      widget.orderCoffeeModel.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Rosarivo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.orderCoffeeModel.type,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'Rosarivo',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      '\$ ${widget.orderCoffeeModel.price.toString()}',
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
                CustomSmallButton(
                  iconData: Icons.remove,
                  onTap: () {
                    setState(() {
                      if (widget.orderCoffeeModel.count > 1) {
                        widget.orderCoffeeModel.count--;
                      }
                    });
                  },
                ),
                const SizedBox(width: 5),
                Text(widget.orderCoffeeModel.count.toString(),
                    style: const TextStyle(color: Colors.white, fontSize: 25)),
                const SizedBox(width: 5),
                CustomSmallButton(
                  iconData: Icons.add,
                  onTap: () {
                    setState(() {
                      widget.orderCoffeeModel.count++;
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
