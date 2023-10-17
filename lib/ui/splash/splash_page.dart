import 'package:coffee_shop/data/local/storage_repo.dart';
import 'package:coffee_shop/ui/route/route.dart';
import 'package:coffee_shop/utils/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));
    if (context.mounted && StorageRepository.getString("isAdmin").isNotEmpty) {
      context.go(RouteNames.tabBoxAdminScreen);
    } else if (context.mounted) {
      context.go(RouteNames.tabBoxScreen);
    }
  }

  @override
  void initState() {
    _init(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.bg,
            height: 2000,
            fit: BoxFit.fill,
          ),
          const Positioned(
            left: 100,
            top: 200,
            child: Text(
              "Coffee Shop",
              style: TextStyle(
                color: Colors.white,
                fontSize: 40,
              ),
            ),
          ),
          const Positioned(
            left: 50,
            bottom: 200,
            child: Text(
              "Feeling low? Take a sip of coffee...!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          )
        ],
      ),
    );
  }
}
