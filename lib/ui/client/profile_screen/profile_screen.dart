import 'package:coffee_shop/cubit/auth_cubit/auth_cubit.dart';
import 'package:coffee_shop/data/local/storage_repo.dart';
import 'package:coffee_shop/ui/route/route.dart';
import 'package:coffee_shop/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap: (() => FocusScope.of(context).unfocus()),
      child: Scaffold(
        backgroundColor: AppColors.primaryBg,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Are you an Admin?",
              style: GoogleFonts.rosarivo(color: Colors.white, fontSize: 25),
            ),
            Center(
              child: SizedBox(
                height: h * 0.35,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.itemColor,
                    borderRadius: BorderRadius.circular(h * 0.023),
                  ),
                  width: w * 0.9,
                  height: h * 0.36,
                  child: Container(
                    padding: EdgeInsets.all(h * 0.02),
                    child: Column(
                      children: [
                        TextFormField(
                          onChanged: (value) {
                            context.read<AuthCubit>().updatePhone(value);
                          },
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.01,
                        ),
                        TextFormField(
                          onChanged: (value) {
                            context.read<AuthCubit>().updatePassword(value);
                          },
                          decoration: InputDecoration(
                            labelText: ('Password'),
                            labelStyle:
                                const TextStyle(fontWeight: FontWeight.bold),
                            border: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.purple.shade600),
                            ),
                          ),
                        ),
                        SizedBox(height: h * 0.045),
                        SizedBox(
                          height: h * 0.06,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(h * 0.01),
                              ),
                            ),
                            onPressed: (() async {
                              if (context
                                  .read<AuthCubit>()
                                  .canAuthenticate()
                                  .isEmpty) {
                                await context.read<AuthCubit>().logIn(context);
                                if (StorageRepository.getString("isAdmin")
                                        .isNotEmpty &&
                                    context.mounted) {
                                  context.go(RouteNames.tabBoxAdminScreen);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(context
                                          .read<AuthCubit>()
                                          .canAuthenticate()),
                                      backgroundColor: Colors.red,
                                      duration: const Duration(seconds: 2)),
                                );
                              }
                            }),
                            child: const Center(
                              child: Text(
                                'Sign In',
                                style: TextStyle(color: AppColors.itemColor),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
