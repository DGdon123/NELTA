import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/auth/data/models/change_password_model/password_change_respones_model.dart';
import 'package:nelta/features/auth/data/models/login%20model/login_response_model.dart';
import 'package:nelta/features/auth/presentation/controllers/change_password/presentation/change_password_controller.dart';
import 'package:nelta/features/auth/presentation/controllers/loading_controller.dart';
import 'package:nelta/features/auth/presentation/widgets/custom_form.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  late TextEditingController emailController;
  late TextEditingController oldpasswordController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  final formKey = GlobalKey<FormState>();
  bool remberPassword = false;
  late bool isPasswordsvisible;
  late bool isConfirmPasswordvisible;
  late bool isOldPasswordvisible;
  String email = "";
  String isLifeMember = "";
  userDataLoad() async {
    final String lifeMember = await DbClient().getData(dbKey: "lifeMember");
    final String data = await DbClient().getData(dbKey: "userData");
    final LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(data);
    setState(() {
      isLifeMember = lifeMember;
      email = loginResponseModel.email.toString();
      // log(email.toString());
    });
  }

  @override
  void initState() {
    userDataLoad();
    isOldPasswordvisible = true;
    isPasswordsvisible = true;
    isConfirmPasswordvisible = true;
    confirmPasswordController = TextEditingController();
    emailController = TextEditingController(text: email);
    passwordController = TextEditingController();
    oldpasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    oldpasswordController.dispose();
    super.dispose();
  }

  phoneValidation(String? value) {
    if (value!.isEmpty && value.length <= 9) {
      return "AppFormMessage.phoneNumberValidationMessage";
    }
    return null;
  }

  oldPasswordValid(String? value) {
    if (value!.isEmpty && value.length <= 6) {
      return "Please old password";
    }
    // if (value.length <= 6) {
    //   return "AppFormMessage.passwordValidatCountMessage";
    // }
    return null;
  }

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
    if (val != passwordController.text) return 'Password did not match';
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

  toogleOldPassword() {
    setState(() {});
    isOldPasswordvisible = !isOldPasswordvisible;
  }

  toogleConfirmPasswordVisibility() {
    setState(() {});
    isConfirmPasswordvisible = !isConfirmPasswordvisible;
  }

  String? enrollMentGroupValue;
  String? userTypeGroupValue;
  String? lifeMemberGroupValue;

  changePassword() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (formKey.currentState!.validate()) {
      if (connectivityResult == ConnectivityResult.none) {
        // Show an error if there is no internet connection
        if (context.mounted) {
          showGeneralDialog(
              barrierColor: Colors.black.withOpacity(0.5),
              transitionBuilder: (context, a1, a2, widget) {
                return ScaleTransition(
                    scale: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                    child: FadeTransition(
                      opacity: Tween<double>(begin: 0.5, end: 1.0).animate(a1),
                      child: const AlertDialog(
                        title: Text(
                          'No Internet Connection',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ));
              },
              transitionDuration: const Duration(milliseconds: 300),
              barrierDismissible: true,
              barrierLabel: '',
              context: context,
              pageBuilder: (context, animation1, animation2) {
                return Container();
              });
        }
        return;
      }
      if (context.mounted) {
        PasswordChnageRequestModel changePassword = PasswordChnageRequestModel(
            is_member: isLifeMember == "true" ? 1 : null,
            oldPassword: oldpasswordController.text,
            email: email,
            password: passwordController.text.trim());
        ref.read(loginloadingProvider.notifier).update((state) => true);
        await ref
            .read(changePasswordControllerProvider.notifier)
            .changePasswordC(
                context: context, passwordChnageRequestModel: changePassword);
        ref.read(loginloadingProvider.notifier).update((state) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConst.kappBarChangePassword,
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                CustomTextformFormField(
                  enabledTextformField: false,
                  istextCapitilization: true,
                  hintText: AppConst.kEmail,
                  isLablerequire: true,
                  controller: TextEditingController(text: email),
                  label: AppConst.kFullName,
                  isLableIconrequire: true,
                  iconData: Icons.lock_outline,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                ),
                CustomTextformFormField(
                    obscureText: isOldPasswordvisible,
                    issuffixIconrequired: IconButton(
                        onPressed: toogleOldPassword,
                        icon: Icon(
                          isOldPasswordvisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16,
                        )),
                    hintText: AppConst.kEnterOldPassword,
                    isLablerequire: true,
                    controller: oldpasswordController,
                    // label: AppConst.kPassword,
                    isLableIconrequire: true,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) => oldPasswordValid(value)),
                CustomTextformFormField(
                    obscureText: isConfirmPasswordvisible,
                    issuffixIconrequired: IconButton(
                        onPressed: toogleConfirmPasswordVisibility,
                        icon: Icon(
                          isConfirmPasswordvisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16,
                        )),
                    hintText: AppConst.kEnterNEwPassword,
                    isLablerequire: true,
                    controller: passwordController,
                    // label: AppConst.kPassword,
                    isLableIconrequire: true,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (value) => passwordValidation(value)),
                CustomTextformFormField(
                    obscureText: isPasswordsvisible,
                    issuffixIconrequired: IconButton(
                        onPressed: toogleVisibility,
                        icon: Icon(
                          isPasswordsvisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16,
                        )),
                    hintText: AppConst.kConfirmPassword,
                    isLablerequire: true,
                    controller: confirmPasswordController,
                    label: AppConst.kConfirmPassword,
                    isLableIconrequire: true,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.done,
                    validator: (val) => confirmPasswordValidation(val)
                    //  confirmPasswordValidation(value)
                    ),
                SizedBox(
                  height: screenH * 0.01,
                ),
                SizedBox(
                  height: screenH * 0.02,
                ),
                ref.watch(loginloadingProvider)
                    ? const Center(child: CircularProgressIndicator.adaptive())
                    : ElevatedButton(
                        style: ElevatedButtonTheme.of(context).style,
                        onPressed: () async => await changePassword(),
                        child: const Text(
                          AppConst.kUpdatePassword,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
