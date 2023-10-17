import 'package:coffee_shop/cubit/coonectivity_cubit/connectivity_cubit.dart';
import 'package:coffee_shop/ui/splash/splash_page.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoInternetScreen extends StatelessWidget {
  final VoidCallback voidCallback;

  const NoInternetScreen({required this.voidCallback, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BlocListener<ConnectivityCubit, ConnectivityState>(
        listener: (context, state) {
          if (state.connectivityResult != ConnectivityResult.none) {
            voidCallback.call();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const SplashScreen(),
                ),
                    (route) => false);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.primaryBg,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(
                child: Icon(
                    Icons.signal_cellular_connected_no_internet_0_bar,size: 70,color: AppColors.buttonColor, ),
              ),
              const SizedBox(
                height: 50,
              ),
              Text("Internet connection not found!!!",
                  style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}