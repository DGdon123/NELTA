import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/check_code/check_code_request_model.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/check_code/check_code_response_model.dart';
import 'package:nelta/features/auth/data/repositories/auth_repository.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

import '../../../../../../utils/custom_navigation/app_nav.dart';
import '../presentation/set_new_password.dart';

class CheckCodeController
    extends StateNotifier<AsyncValue<CheckCodeForgotPasswordResponseModel>> {
  CheckCodeController(this.authRepositories) : super(AsyncValue.loading());
  final AuthRepositories authRepositories;

  checkCode({
    required BuildContext context,
    required CheckCodeForgotPasswordRequestModel
        checkCodeForgotPasswordRequestModel,
    required String token,
    required EmailLifmemberModel emailLifmemberModel,
  }) async {
    final result = await authRepositories.checkCodePasswordForgotRepo(
      checkCodeForgotPasswordRequestModel: checkCodeForgotPasswordRequestModel,
      token: token,
    );
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
        ScaffoldMessenger.of(context).clearSnackBars();
        showCustomSnackBar(r.success, context, isError: false);
        normalNav(
            context,
            SetNewPassword(
                email: emailLifmemberModel.email,
                lifeMemberValue: emailLifmemberModel.lifeMemberValue));
      }
    });
  }
}

final checkCodeControllerProvider = StateNotifierProvider<CheckCodeController,
    AsyncValue<CheckCodeForgotPasswordResponseModel>>((ref) {
  return CheckCodeController(ref.read(authRepositoriesProvider));
});

class EmailLifmemberModel {
  final String email;
  final int? lifeMemberValue;

  EmailLifmemberModel({required this.email, required this.lifeMemberValue});
}
