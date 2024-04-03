import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/dashboard.dart';
import 'package:nelta/features/auth/data/models/login%20model/login_request_model.dart';
import 'package:nelta/features/auth/data/models/login%20model/login_response_model.dart';
import 'package:nelta/features/auth/data/repositories/auth_repository.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

import '../../../../../utils/custom_navigation/app_nav.dart';

class LoginController extends StateNotifier<AsyncValue<LoginResponseModel>> {
  LoginController(this.authRepositories) : super(const AsyncValue.loading());
  final AuthRepositories authRepositories;

  loginC(
    LoginRequestModel loginRequestModel,
    BuildContext context,
    String token,
  ) async {
    final result = await authRepositories.loginRepo(loginRequestModel, token);
    result.fold((l) {
      log(l.message.toString());
      showCustomSnackBar("Your email or password do not match", context);
      return state = AsyncValue.error(
        l,
        StackTrace.fromString(l.message),
      );
    }, (r) async {
      await DbClient().setData(dbKey: "token", value: token);

      state = AsyncValue.data(r);
      await DbClient().setData(dbKey: "userData", value: r.toJson());

      if (context.mounted) {
        // showCustomSnackBar("Welcome to NELTA", context, isError: false);

        pushAndRemoveUntil(context, const Dashboard());
      }
    });
  }
}

final authControllerProvider =
    StateNotifierProvider<LoginController, AsyncValue<LoginResponseModel>>(
        (ref) {
  return LoginController(ref.watch(authRepositoriesProvider));
});
