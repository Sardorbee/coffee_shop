import 'package:coffee_shop/data/local/storage_repo.dart';
import 'package:coffee_shop/data/models/form_status.dart';
import 'package:coffee_shop/data/models/universal_data.dart';
import 'package:coffee_shop/data/repositories/auth_repo.dart';
import 'package:coffee_shop/utils/show_loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(const AuthState());

  void updatePassword(String password) {
    emit(state.copyWith(password: password));
  }

  final AuthRepository authRepository;

  void updatePhone(String email) {
    debugPrint("AUTH PHONE: $email");
    emit(state.copyWith(email: email));
  }

  Future<void> logOutUser() async {
    emit(state.copyWith(status: FormStatus.loading));
    UniversalData data = await authRepository.logOutUser();
    if (data.error.isEmpty) {
      emit(state.copyWith(status: FormStatus.unauthenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.error,
          statusMessage: data.error,
        ),
      );
    }
  }

  Future<void> signUp(context) async {
    emit(state.copyWith(status: FormStatus.loading));
    showLoading(context: context);
    UniversalData data = await authRepository.signUpUser(
      email: state.email,
      password: state.password,
    );
    hideLoading(context: context);
    if (data.error.isNotEmpty) {
      emit(state.copyWith(status: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.error,
          statusMessage: data.error,
        ),
      );
    }
    emit(state.copyWith(status: FormStatus.pure));
  }

  Future<void> logIn(context) async {
    emit(state.copyWith(status: FormStatus.loading));
    showLoading(context: context);
    UniversalData data = await authRepository.loginUser(
      email: state.email,
      password: state.password,
    );
    hideLoading(context: context);

    if (data.error.isEmpty) {
      UserCredential x = data.data;
      StorageRepository.putString("isAdmin", x.user!.uid);
      emit(state.copyWith(status: FormStatus.authenticated));
    } else {
      emit(
        state.copyWith(
          status: FormStatus.error,
          statusMessage: data.error,
        ),
      );
    }
    emit(state.copyWith(status: FormStatus.pure));
  }

  String canAuthenticate() {
    if (!state.email.endsWith("@gmail.com")) {
      return "Enter Valid Email";
    }
    if (state.password.length < 6) {
      return "Enter Valid Password";
    }
    return "";
  }
}
