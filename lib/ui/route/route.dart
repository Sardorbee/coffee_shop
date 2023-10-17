import 'package:coffee_shop/data/models/coffee_model.dart';
import 'package:coffee_shop/ui/admin/home_screen/widgets/add_coffee.dart';
import 'package:coffee_shop/ui/admin/tab_box_admin.dart';
import 'package:coffee_shop/ui/client/cart_screen/cart_screen.dart';
import 'package:coffee_shop/ui/client/homescreen/coffee_detail.dart';
import 'package:coffee_shop/ui/client/tab_box.dart';
import 'package:coffee_shop/ui/splash/app.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

GoRouter myRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(path: "/", builder: (context, state) => const AppLevel()),
    GoRoute(
        path: "/tab_box_admin",
        builder: (context, state) => const TabBoxAdmin(),
        routes: [
          GoRoute(
            path: "add_coffee",
            builder: (context, state) => const AddCoffeeScreen(),
          )
        ]),
    GoRoute(
        path: "/tab_box",
        builder: (context, state) => const TabBox(),
        routes: [
          GoRoute(
            path: "coffee_detail",
            builder: (context, state) {
              CoffeeModel extras = state.extra as CoffeeModel;
              return CoffeeDetailScreen(coffeeModel: extras);
            },
          ),
          GoRoute(
            path: "CartScreen",
            builder: (context, state) => const CartScreen(),
          ),
        ]),
  ],
);

class RouteNames {
  static const String splashScreen = "/";
  static const String cartScreen = "/CartScreen";
  static const String tabBoxScreen = "/tab_box";
  static const String tabBoxAdminScreen = "/tab_box_admin";
  // static const String homeScreenClient = "$tabBoxScreen/home_screen_client";
  static const String detailsScreenClient = "$tabBoxScreen/coffee_detail";
  static const String homeScreenAdmin = "/home_screen_admin";
  static const String addCoffeeScreenAdmin = "$tabBoxAdminScreen/add_coffee";
}
