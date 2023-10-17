import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/auth/data/repositories/auth_repository.dart';
import 'package:nelta/features/auth/presentation/login/login_screen.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

import '../../../../data/models/forgot_password_model/set_new_password/setnew_password_request_model.dart';
import '../../../../data/models/forgot_password_model/set_new_password/setnew_password_response_model.dart';

class UpdatePasswordFGController
    extends StateNotifier<AsyncValue<SetNewsPasswordFGResponseModel>> {
  UpdatePasswordFGController(this.authRepositories)
      : super(AsyncValue.loading());
  final AuthRepositories authRepositories;

  updatePassword({
    required BuildContext context,
    required SetPasswordRequestModel setPasswordRequestModel,
    required String token,
  }) async {
    final result = await authRepositories.setNewPasswordRepo(
      setPasswordRequestModel: setPasswordRequestModel,
      token: token,
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
        showCustomSnackBar(r.success, context, isError: false);
        pushAndRemoveUntil(context, LoginScreen());
      }
    });
  }
}

final updatePasswordFGControllerProvider = StateNotifierProvider<
    UpdatePasswordFGController,
    AsyncValue<SetNewsPasswordFGResponseModel>>((ref) {
  return UpdatePasswordFGController(ref.read(authRepositoriesProvider));
});
