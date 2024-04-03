import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/auth/data/repositories/auth_repository.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';
import '../../../../../core/api_const/db_client.dart';
import '../../../../../dashboard.dart';
import '../../../../../utils/custom_navigation/app_nav.dart';
import '../../../data/models/login model/login_response_model.dart';
import '../../../data/models/signmodel/sign_upmodel.dart';

class SingupController extends StateNotifier<AsyncValue<LoginResponseModel>> {
  SingupController(this.authRepositories) : super(const AsyncValue.loading());
  final AuthRepositories authRepositories;
  signUpC(
      {required SignUpRequestModel signUpRequestModel,
      required String token,
      required BuildContext context}) async {
    final result = await authRepositories.singUpRepo(signUpRequestModel, token);
    return result.fold((l) {
      showCustomSnackBar(l.message, context);
      state = AsyncValue.error(
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

final signUpControllerProvider =
    StateNotifierProvider<SingupController, AsyncValue<LoginResponseModel>>(
        (ref) {
  return SingupController(ref.read(authRepositoriesProvider));
});
