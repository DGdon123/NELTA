import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/auth/data/repositories/auth_repository.dart';
import 'package:nelta/features/auth/presentation/forgot%20password/check_code/presentation/check_code_screen.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

import '../../../../data/models/forgot_password_model/check_code/forgot_password_request_model.dart';
import '../../../../data/models/forgot_password_model/check_code/forgot_password_response_model.dart';
import 'check_code_controller.dart';

class ForgotPasswordGetCodeController
    extends StateNotifier<AsyncValue<ForgotPasswordResponseModel>> {
  ForgotPasswordGetCodeController(this.authRepositories)
      : super(AsyncValue.loading());
  final AuthRepositories authRepositories;

  getCode({
    required BuildContext context,
    required ForgotPasswordRequestModel forgotPasswordRequestModel,
    required String token,
    required EmailLifmemberModel emailLifmemberModel,
  }) async {
    final result = await authRepositories.getCodePasswordForgotRepo(
        forgotPasswordRequestModel: forgotPasswordRequestModel, token: token);
    return result.fold((l) {
      ScaffoldMessenger.of(context).clearSnackBars();
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(
        l,
        StackTrace.fromString(l.message),
      );
    }, (r) async {
      state = AsyncValue.data(r);
      if (context.mounted) {
        showCustomSnackBar(r.success, context, isError: false);
        normalNav(
            context,
            CheckCodeScreen(
                email: emailLifmemberModel.email,
                lifeMemberValue: emailLifmemberModel.lifeMemberValue));

        // pushAndRemoveUntil(context, const Dashboard());
      }
    });
  }
}

final getCodeControllerProvider = StateNotifierProvider<
    ForgotPasswordGetCodeController,
    AsyncValue<ForgotPasswordResponseModel>>((ref) {
  return ForgotPasswordGetCodeController(ref.read(authRepositoriesProvider));
});
