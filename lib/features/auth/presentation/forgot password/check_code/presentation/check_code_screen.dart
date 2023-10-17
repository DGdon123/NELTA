import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/check_code/check_code_request_model.dart';
import 'package:nelta/features/auth/data/models/token_model/token_request_model.dart';
import 'package:nelta/features/auth/data/repositories/token_repository.dart';
import 'package:nelta/features/auth/presentation/controllers/loading_controller.dart';
import 'package:nelta/features/auth/presentation/forgot%20password/check_code/controller/check_code_controller.dart';
import 'package:nelta/features/auth/presentation/widgets/custom_form.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

import '../../../../data/models/forgot_password_model/check_code/forgot_password_request_model.dart';
import '../../../../data/repositories/auth_repository.dart';

class CheckCodeScreen extends ConsumerStatefulWidget {
  const CheckCodeScreen(
      {super.key, required this.email, required this.lifeMemberValue});
  final int? lifeMemberValue;
  final String email;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CheckCodeScreenState();
}

class _CheckCodeScreenState extends ConsumerState<CheckCodeScreen> {
  late TextEditingController codeController;

  codeValidate(String? value) {
    if (value!.isEmpty && value.length < 6) {
      return "Please enter valid code";
    }

    return null;
  }

  @override
  void initState() {
    codeController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    codeController.dispose();

    super.dispose();
  }

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final requestCodeLoading = ref.watch(requestCodeAgainControllerLoading);
    final veryLoading =
        ref.watch(veryCodeForgotPasswordControllerLoadingProvider);
    final double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("Veify Code"),
      ),
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            child: Column(
              children: [
                CustomTextformFormField(
                    hintText: AppConst.kCode,
                    controller: codeController,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) => codeValidate(value)),
                requestCodeLoading
                    ? LinearProgressIndicator()
                    : Align(
                        alignment: Alignment.topRight,
                        child: CupertinoButton(
                            child: Text(
                              "Request code again",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "PS",
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () async {
                              TokenRequestModel auhtModel = TokenRequestModel(
                                  email: ApiConst.getTokenUserEmail,
                                  password: ApiConst.getTokenUserPassword);
                              ForgotPasswordRequestModel changePassword =
                                  ForgotPasswordRequestModel(
                                is_member: widget.lifeMemberValue,
                                email: widget.email,
                              );
                              ref
                                  .read(requestCodeAgainControllerLoading
                                      .notifier)
                                  .update((state) => true);
                              if (context.mounted) {
                                final token = await ref
                                    .read(tokenRepositoryProvider)
                                    .requestTokenRepo(auhtModel);
                                token.fold((l) {
                                  showCustomSnackBar(l.message, context,
                                      isError: true);

                                  ref
                                      .read(requestCodeAgainControllerLoading
                                          .notifier)
                                      .update((state) => false);
                                }, (r) async {
                                  final requestCode = await ref
                                      .read(authRepositoriesProvider)
                                      .getCodePasswordForgotRepo(
                                          forgotPasswordRequestModel:
                                              changePassword,
                                          token: r.token);

                                  ref
                                      .read(requestCodeAgainControllerLoading
                                          .notifier)
                                      .update((state) => false);
                                  requestCode.fold((l) {
                                    showCustomSnackBar(l.message, context,
                                        isError: true);

                                    ref
                                        .read(requestCodeAgainControllerLoading
                                            .notifier)
                                        .update((state) => false);
                                  }, (r) async {
                                    showCustomSnackBar(r.success, context,
                                        isError: false);

                                    ref
                                        .read(requestCodeAgainControllerLoading
                                            .notifier)
                                        .update((state) => false);
                                  });
                                  // await ref
                                  //     .read(getCodeControllerProvider.notifier)
                                  //     .getCode(
                                  //         token: r.token,
                                  //         context: context,
                                  //         forgotPasswordRequestModel: changePassword,
                                  //         emailLifmemberModel: EmailLifmemberModel(
                                  //             email: widget.email,
                                  //             lifeMemberValue:
                                  //                 widget.lifeMemberValue));
                                });
                              }
                            }),
                      ),
                SizedBox(
                  height: screenH * 0.01,
                ),
                veryLoading
                    ? CircularProgressIndicator.adaptive()
                    : Visibility(
                        visible: !requestCodeLoading,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0),
                            onPressed: () async {
                              var connectivityResult =
                                  await (Connectivity().checkConnectivity());
                              if (formKey.currentState!.validate()) {
                                if (connectivityResult ==
                                    ConnectivityResult.none) {
                                  // Show an error if there is no internet connection
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
                                CheckCodeForgotPasswordRequestModel
                                    checkCodeForgotPasswordRequestModel =
                                    CheckCodeForgotPasswordRequestModel(
                                        email: widget.email,
                                        is_member: widget.lifeMemberValue,
                                        reset_code: codeController.text.trim());
                                TokenRequestModel auhtModel = TokenRequestModel(
                                    email: ApiConst.getTokenUserEmail,
                                    password: ApiConst.getTokenUserPassword);

                                ref
                                    .read(
                                        veryCodeForgotPasswordControllerLoadingProvider
                                            .notifier)
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
                                            veryCodeForgotPasswordControllerLoadingProvider
                                                .notifier)
                                        .update((state) => false);
                                  }, (r) async {
                                    await ref
                                        .read(checkCodeControllerProvider
                                            .notifier)
                                        .checkCode(
                                            token: r.token,
                                            context: context,
                                            checkCodeForgotPasswordRequestModel:
                                                checkCodeForgotPasswordRequestModel,
                                            emailLifmemberModel:
                                                EmailLifmemberModel(
                                                    email: widget.email,
                                                    lifeMemberValue: widget
                                                        .lifeMemberValue));
                                    ref
                                        .read(
                                            veryCodeForgotPasswordControllerLoadingProvider
                                                .notifier)
                                        .update((state) => false);
                                  });
                                }
                              }
                            },
                            child: Text(
                              "Sumit",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
