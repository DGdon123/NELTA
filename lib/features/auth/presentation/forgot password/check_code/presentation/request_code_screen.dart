import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/auth/data/models/token_model/token_request_model.dart';
import 'package:nelta/features/auth/data/repositories/token_repository.dart';
import 'package:nelta/features/auth/presentation/forgot%20password/check_code/controller/check_code_controller.dart';
import 'package:nelta/features/auth/presentation/widgets/custom_form.dart';
import 'package:nelta/utils/form_validation/form_input_validation.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';
import '../../../../data/models/forgot_password_model/check_code/forgot_password_request_model.dart';
import '../../../controllers/loading_controller.dart';

import '../controller/forgot_password_getcode_controller.dart';

final showCodeTextformFieldProvider = StateProvider<bool>((ref) {
  return false;
});

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key, required this.lifeMemberValue});
  final int? lifeMemberValue;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  late TextEditingController emailController;
  late TextEditingController codeController;
  // late TextEditingController confirmPasswordController;
  final formKey = GlobalKey<FormState>();
  bool remberPassword = false;
  late bool isPasswordsvisible;
  late bool isConfirmPasswordvisible;
  @override
  void initState() {
    isPasswordsvisible = true;
    isConfirmPasswordvisible = true;
    // confirmPasswordController = TextEditingController();

    emailController = TextEditingController();
    codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    // passwordController.dispose();
    // confirmPasswordController.dispose();
    super.dispose();
  }

  phoneValidation(String? value) {
    if (value!.isEmpty && value.length <= 9) {
      return "AppFormMessage.phoneNumberValidationMessage";
    }
    return null;
  }

  passwordValidation(String? value) {
    if (value!.isEmpty && value.length <= 6) {
      return "AppFormMessage.passwordEmptyValidatorMessage";
    }
    if (value.length <= 6) {
      return "AppFormMessage.passwordValidatCountMessage";
    }
    return null;
  }

  codeValidate(String? value) {
    if (value!.isEmpty && value.length < 6) {
      return "Please enter valid code";
    }

    return null;
  }

  checkBox(value) {
    setState(() {});
    remberPassword = value!;
  }

  toogleVisibility() {
    setState(() {});
    isPasswordsvisible = !isPasswordsvisible;
  }

  toogleConfirmPasswordVisibility() {
    setState(() {});
    isConfirmPasswordvisible = !isConfirmPasswordvisible;
  }

  @override
  Widget build(BuildContext context) {
    final requestForgotPasswordLoading =
        ref.watch(passwordForgotEmailControllerProvider);
    // final enterCode = ref.watch(showCodeTextformFieldProvider);
    final double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.kForgotPasswordAppbar),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextformFormField(
                    istextCapitilization: true,
                    hintText: AppConst.kEmail,
                    isLablerequire: true,
                    controller: emailController,
                    label: AppConst.kFullName,
                    isLableIconrequire: true,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: (value) => value!.isValidEmail(value)),
                SizedBox(
                  height: screenH * 0.01,
                ),
                requestForgotPasswordLoading
                    ? CircularProgressIndicator.adaptive()
                    : ElevatedButton(
                        style: ElevatedButtonTheme.of(context).style,
                        onPressed: () async {
                          var connectivityResult =
                              await (Connectivity().checkConnectivity());
                          if (formKey.currentState!.validate()) {
                            if (connectivityResult == ConnectivityResult.none) {
                              // Show an error if there is no internet connection
                              if (context.mounted) {
                                showGeneralDialog(
                                    barrierColor: Colors.black.withOpacity(0.5),
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
                                                style: TextStyle(fontSize: 16),
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
                            ForgotPasswordRequestModel changePassword =
                                ForgotPasswordRequestModel(
                              is_member: widget.lifeMemberValue,
                              email: emailController.text,
                            );
                            TokenRequestModel auhtModel = TokenRequestModel(
                                email: ApiConst.getTokenUserEmail,
                                password: ApiConst.getTokenUserPassword);
                            ref
                                .read(passwordForgotEmailControllerProvider
                                    .notifier)
                                .update((state) => true);

                            if (context.mounted) {
                              final token = await ref
                                  .read(tokenRepositoryProvider)
                                  .requestTokenRepo(auhtModel);
                              token.fold((l) async {
                                showCustomSnackBar(l.message, context,
                                    isError: true);
                                ref
                                    .read(passwordForgotEmailControllerProvider
                                        .notifier)
                                    .update((state) => false);
                              }, (r) async {
                                await ref
                                    .read(getCodeControllerProvider.notifier)
                                    .getCode(
                                        token: r.token,
                                        context: context,
                                        forgotPasswordRequestModel:
                                            changePassword,
                                        emailLifmemberModel:
                                            EmailLifmemberModel(
                                                email:
                                                    emailController.text.trim(),
                                                lifeMemberValue:
                                                    widget.lifeMemberValue));

                                ref
                                    .read(passwordForgotEmailControllerProvider
                                        .notifier)
                                    .update((state) => false);
                              });
                            }
                          }
                        },
                        child: const Text(
                          AppConst.ksubmit,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
