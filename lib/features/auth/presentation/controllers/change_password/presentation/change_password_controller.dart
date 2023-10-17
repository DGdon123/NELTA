import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/dashboard.dart';
import 'package:nelta/features/auth/data/models/change_password_model/change_password_response_model.dart';
import 'package:nelta/features/auth/data/models/change_password_model/password_change_respones_model.dart';
import 'package:nelta/features/auth/data/repositories/auth_repository.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

class ChangePasswordControllerNotifier
    extends StateNotifier<AsyncValue<ChangePasswordResponseModel>> {
  ChangePasswordControllerNotifier(this.authRepositories)
      : super(AsyncValue.loading());
  final AuthRepositories authRepositories;
  changePasswordC(
      {required BuildContext context,
      required PasswordChnageRequestModel passwordChnageRequestModel}) async {
    final result = await authRepositories.changePasswordRepo(
      passwordChnageRequestModel,
    );
    return result.fold((l) {
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(
        l,
        StackTrace.fromString(l.message),
      );
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        showCustomSnackBar("Password Change Successfully ", context,
            isError: false);
        pushAndRemoveUntil(context, const Dashboard());
      }
    });
  }
}

final changePasswordControllerProvider = StateNotifierProvider<
    ChangePasswordControllerNotifier,
    AsyncValue<ChangePasswordResponseModel>>((ref) {
  return ChangePasswordControllerNotifier(ref.read(authRepositoriesProvider));
});
