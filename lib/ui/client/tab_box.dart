import 'package:coffee_shop/ui/client/cart_screen/cart_screen.dart';
import 'package:coffee_shop/ui/client/homescreen/homescreen.dart';
import 'package:coffee_shop/ui/client/profile_screen/profile_screen.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';

class TabBox extends StatefulWidget {
  const TabBox({super.key});

  @override
  State<TabBox> createState() => _TabBoxState();
}

class _TabBoxState extends State<TabBox> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          HomeScreenClient(),
          CartScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: AppColors.buttonColor,
        unselectedItemColor: Colors.white10,
        backgroundColor: AppColors.primaryBg,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: "Cart"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
