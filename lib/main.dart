import 'package:coffee_shop/bloc/coffee_bloc/coffee_bloc.dart';
import 'package:coffee_shop/bloc/order_bloc/order_bloc.dart';
import 'package:coffee_shop/cubit/auth_cubit/auth_cubit.dart';
import 'package:coffee_shop/cubit/coonectivity_cubit/connectivity_cubit.dart';
import 'package:coffee_shop/data/local/storage_repo.dart';
import 'package:coffee_shop/data/repositories/auth_repo.dart';
import 'package:coffee_shop/data/repositories/coffee_repo.dart';
import 'package:coffee_shop/data/repositories/order_repo.dart';
import 'package:coffee_shop/ui/route/route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await StorageRepository.getInstance();
  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider(
        create: (context) => CoffeeRepo(),
      ),
      RepositoryProvider(
        create: (context) => OrderRepo(),
      ),
      RepositoryProvider(
        create: (context) => AuthRepository(),
      )
    ],
    child: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => CoffeeBloc(),
      ),
      BlocProvider(
        create: (context) => AuthCubit(context.read<AuthRepository>()),
      ),
      BlocProvider(
        create: (context) => OrderBloc(),
      ),BlocProvider(
        create: (context) => ConnectivityCubit(),
      ),
    ], child: const MainApp()),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: myRouter,
    );
  }
}
