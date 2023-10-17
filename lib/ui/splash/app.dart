import 'package:coffee_shop/cubit/coonectivity_cubit/connectivity_cubit.dart';
import 'package:coffee_shop/ui/no_internet/no_internet.dart';
import 'package:coffee_shop/ui/splash/splash_page.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLevel extends StatelessWidget {
  const AppLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ConnectivityCubit, ConnectivityState>(
      listener: (context, state) {
        if (state.connectivityResult == ConnectivityResult.none) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => NoInternetScreen(voidCallback: () {}),
              ),
              (route) => false);
        }
      },
      child: const SplashScreen(),
    );
  }
}
