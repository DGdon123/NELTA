import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/features/auth/data/models/token_model/token_request_model.dart';
import 'package:nelta/features/auth/presentation/controllers/loading_controller.dart';
import 'package:nelta/features/auth/presentation/widgets/custom_form.dart';

import '../../../../../../core/api_const/api_const.dart';
import '../../../../../../utils/snackbar/custome_snack_bar.dart';
import '../../../../data/models/forgot_password_model/set_new_password/setnew_password_request_model.dart';
import '../../../../data/repositories/token_repository.dart';
import '../controller/update_passwordfg_controller.dart';

class SetNewPassword extends ConsumerStatefulWidget {
  const SetNewPassword(
      {super.key, required this.lifeMemberValue, required this.email});
  final int? lifeMemberValue;
  final String email;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends ConsumerState<SetNewPassword> {
  late TextEditingController newPasswordController;
  late TextEditingController confirmNewsPasswordController;

  final formKey = GlobalKey<FormState>();
  // bool remberPassword = false;
  late bool isNewPasswordVisible;
  late bool isNewConfirmPasswordVisible;

  passwordValidation(String? value) {
    if (value!.isEmpty && value.length <= 6) {
      return "Please enter password of atleast 6 characters";
    }
    // if (value.length <= 6) {
    //   return "AppFormMessage.passwordValidatCountMessage";
    // }
    return null;
  }

  confirmPasswordValidation(String? val) {
    if (val!.isEmpty) return 'Please enter password of atleast 6 characters';
    if (val != newPasswordController.text) return 'Password did not match';
    return null;
  }

  @override
  void initState() {
    isNewPasswordVisible = false;
    isNewConfirmPasswordVisible = false;
    newPasswordController = TextEditingController();
    confirmNewsPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmNewsPasswordController.dispose();
    super.dispose();
  }

  toogleVisibility() {
    setState(() {});
    isNewPasswordVisible = !isNewPasswordVisible;
  }

  toogleConfirmPasswordVisibility() {
    setState(() {});
    isNewConfirmPasswordVisible = !isNewConfirmPasswordVisible;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final setnewPasswordLoading = ref.watch(setPasswordControllerLoadinf);
    return Scaffold(
      appBar: AppBar(
        title: Text("Set new password"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  CustomTextformFormField(
                      obscureText: isNewPasswordVisible,
                      issuffixIconrequired: IconButton(
                          onPressed: toogleVisibility,
                          icon: Icon(
                            isNewPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 16,
                          )),
                      hintText: AppConst.kEnterNEwPassword,
                      isLablerequire: true,
                      controller: newPasswordController,
                      // label: AppConst.kPassword,
                      isLableIconrequire: true,
                      iconData: Icons.lock_outline,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (value) => passwordValidation(value)),
                  CustomTextformFormField(
                      obscureText: isNewConfirmPasswordVisible,
                      issuffixIconrequired: IconButton(
                          onPressed: toogleConfirmPasswordVisibility,
                          icon: Icon(
                            isNewConfirmPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            size: 16,
                          )),
                      hintText: AppConst.kConfirmPassword,
                      isLablerequire: true,
                      controller: confirmNewsPasswordController,
                      label: AppConst.kConfirmPassword,
                      isLableIconrequire: true,
                      iconData: Icons.lock_outline,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                      validator: (val) => confirmPasswordValidation(val)
                      //  confirmPasswordValidation(value)
                      ),
                  setnewPasswordLoading
                      ? CircularProgressIndicator.adaptive()
                      : ElevatedButton(
                          style: ElevatedButtonTheme.of(context).style,
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());

                            if (formKey.currentState!.validate()) {
                              if (connectivityResult ==
                                  ConnectivityResult.none) {
                                if (context.mounted) {
                                  showGeneralDialog(
                                      barrierColor:
                                          Colors.black.withOpacity(0.5),
                                      transitionBuilder:
                                          (context, a1, a2, widget) {
                                        return ScaleTransition(
                                            scale: Tween<double>(
                                                    begin: 0.5, end: 1.0)
                                                .animate(a1),
                                            child: FadeTransition(
                                              opacity: Tween<double>(
                                                      begin: 0.5, end: 1.0)
                                                  .animate(a1),
                                              child: const AlertDialog(
                                                title: Text(
                                                  'No Internet Connection',
                                                  style:
                                                      TextStyle(fontSize: 16),
                                                ),
                                              ),
                                            ));
                                      },
                                      transitionDuration:
                                          const Duration(milliseconds: 300),
                                      barrierDismissible: true,
                                      barrierLabel: '',
                                      context: context,
                                      pageBuilder:
                                          (context, animation1, animation2) {
                                        return Container();
                                      });
                                }
                                return;
                              }
                              SetPasswordRequestModel setPasswordRequestModel =
                                  SetPasswordRequestModel(
                                      password:
                                          newPasswordController.text.trim(),
                                      is_member: widget.lifeMemberValue,
                                      email: widget.email);
                              TokenRequestModel auhtModel = TokenRequestModel(
                                  email: ApiConst.getTokenUserEmail,
                                  password: ApiConst.getTokenUserPassword);
                              ref
                                  .read(setPasswordControllerLoadinf.notifier)
                                  .update((state) => true);
                              if (context.mounted) {
                                final token = await ref
                                    .read(tokenRepositoryProvider)
                                    .requestTokenRepo(auhtModel);

                                token.fold((l) {
                                  showCustomSnackBar(l.message, context,
                                      isError: true);
                                  ref
                                      .read(
                                          setPasswordControllerLoadinf.notifier)
                                      .update((state) => false);
                                }, (r) async {
                                  await ref
                                      .read(updatePasswordFGControllerProvider
                                          .notifier)
                                      .updatePassword(
                                          token: r.token,
                                          context: context,
                                          setPasswordRequestModel:
                                              setPasswordRequestModel);

                                  ref
                                      .read(
                                          setPasswordControllerLoadinf.notifier)
                                      .update((state) => false);
                                });
                              }
                            }
                          },
                          child: const Text(
                            AppConst.kUpdatePassword,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                ],
              ),
            )),
      ),
    );
  }
}
