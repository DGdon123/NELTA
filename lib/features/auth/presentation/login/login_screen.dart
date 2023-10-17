import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/app_const/app_images.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/auth/data/models/login%20model/login_request_model.dart';
import 'package:nelta/features/auth/data/models/token_model/token_request_model.dart';
import 'package:nelta/features/auth/data/repositories/token_repository.dart';
import 'package:nelta/features/auth/presentation/controllers/auth/login_controller.dart';
import 'package:nelta/features/auth/presentation/controllers/loading_controller.dart';
import 'package:nelta/features/auth/presentation/widgets/custom_form.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import 'package:nelta/utils/form_validation/form_input_validation.dart';
import '../controllers/country/country_controller.dart';
import '../forgot password/check_code/presentation/request_code_screen.dart';
import '../singup/sign_up_screen.dart';

final islifeMemberProviderProvider = StateProvider<bool>((ref) {
  return false;
});

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool islifeMember = false;
  late bool isvisible;
  int? lifeMemberValue = null;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    islifeMember = false;
    isvisible = true;
    emailController = TextEditingController();
    passwordController = TextEditingController();
    // passwordController = TextEditingController();
    // setLifeMemberValue();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // setLifeMemberValue() async {
  //   await DbClient()
  //       .setData(dbKey: "lifeMember", value: islifeMember ? "true" : "false");
  //   final String data = await DbClient().getData(dbKey: "lifeMember");
  //   print(data);
  // }

  dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      return currentFocus.unfocus();
    }
  }

  toogleVisibility() {
    setState(() {});
    isvisible = !isvisible;
  }

  checkBox(value) async {
    if (mounted)
      setState(() {
        islifeMember = value!;
        islifeMember == true ? lifeMemberValue = 1 : lifeMemberValue = null;
      });
    islifeMember
        ? ref
            .read(islifeMemberProviderProvider.notifier)
            .update((state) => true)
        : ref
            .read(islifeMemberProviderProvider.notifier)
            .update((state) => false);
    await DbClient()
        .setData(dbKey: "lifeMember", value: islifeMember ? "true" : "false");
  }

  loginFunction() async {
    final String data = await DbClient().getData(dbKey: "lifeMember");
    print(data);
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
      TokenRequestModel auhtModel = TokenRequestModel(
          email: ApiConst.getTokenUserEmail,
          password: ApiConst.getTokenUserPassword);
      LoginRequestModel loginModel1 = LoginRequestModel(
          is_member: lifeMemberValue,
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      ref.read(loginloadingProvider.notifier).update((state) => true);
      if (context.mounted) {
        final token =
            await ref.read(tokenRepositoryProvider).requestTokenRepo(auhtModel);

        return token.fold((l) {
          ref.read(loginloadingProvider.notifier).update((state) => false);
          return "Show error snackbar";
        }, (r) async {
          await ref
              .read(authControllerProvider.notifier)
              .loginC(loginModel1, context, r.token);

          ref.read(loginloadingProvider.notifier).update((state) => false);
        });
      }

      // ref.read(loginloadingProvider.notifier).state = false;
      ref.read(loginloadingProvider.notifier).update((state) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("----------");
    print(lifeMemberValue);
    print("----------");
    final double screenW = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: dismissKeyboard,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                // SizedBox(
                //   height: screenW * 0.2,
                // ),
                Stack(
                  // alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        // color: AppColorResources.appBrowColor,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                        ),
                      ),
                      width: screenW,
                      height: 150,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 80),
                      child: Center(
                        child: Image.asset(
                          AppImages.appLogo,
                          height: screenW * 0.23,
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenW * 0.08,
                      ),
                      Text(AppConst.appFullName,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: AppColorResources.appSecondaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)
                          //  TextStyle(color: AppColorResources.appSecondaryColor,),
                          ),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                if (mounted)
                                  setState(() {
                                    lifeMemberValue = 1;

                                    // islifeMember = !islifeMember;
                                  });
                                await DbClient().setData(
                                    dbKey: "lifeMember", value: "true");
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(),
                                alignment: Alignment.center,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    "NELTA Member",
                                    style: TextStyle(
                                        fontFamily: "PS",
                                        color: lifeMemberValue == 1
                                            ? Colors.white
                                            : Colors.grey),
                                  ),
                                ),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 4, vertical: 0),
                                // width: 100,
                                height: 38,
                                decoration: BoxDecoration(
                                    color: lifeMemberValue == 1
                                        ? AppColorResources.appPrimaryColor
                                        : Color(0xffF1F1F1),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),
                            //Replace button and word
                            InkWell(
                              onTap: () async {
                                if (mounted)
                                  setState(() {
                                    lifeMemberValue = null;
                                    // islifeMember = !islifeMember;
                                  });
                                await DbClient().setData(
                                    dbKey: "lifeMember", value: "false");
                              },
                              child: Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "Visitor",
                                  style: TextStyle(
                                      fontFamily: "PS",
                                      color: lifeMemberValue == null
                                          ? Colors.white
                                          : Colors.grey),
                                ),
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                width: 100,
                                height: 38,
                                decoration: BoxDecoration(
                                    color: lifeMemberValue == null
                                        ? AppColorResources.appPrimaryColor
                                        : Color(0xffF1F1F1),
                                    borderRadius: BorderRadius.circular(8)),
                              ),
                            ),

                            // UsertypeCard(
                            //   onTap: () {
                            //     setState(() {});
                            //     lifeMemberValue = 1;
                            //     islifeMember = islifeMember;
                            //   },
                            //   lable: "Memeber",
                            //   isMember: islifeMember,
                            // ),
                            // UsertypeCard(
                            //     onTap: () {
                            //       lifeMemberValue = null;
                            //       islifeMember = !islifeMember;
                            //     },
                            //     lable: "User",
                            //     isMember: islifeMember)
                          ],
                        ),
                      ),
                      CustomTextformFormField(
                        hintText: AppConst.kEmailMemberShipNumber,
                        isLablerequire: true,
                        controller: emailController,
                        label: AppConst.kPassword,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        validator: (input) => validateInput(input),
                      ),
                      CustomTextformFormField(
                        obscureText: isvisible,
                        hintText: AppConst.kPassword,
                        issuffixIconrequired: IconButton(
                            onPressed: toogleVisibility,
                            icon: Icon(
                              isvisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 16,
                            )),
                        isLablerequire: true,
                        controller: passwordController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                        validator: (input) => input!.isPasswordValid(input),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(
                      //       horizontal: 10, vertical: 10),
                      //   child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.start,
                      //       children: [
                      //         SizedBox(
                      //             height: 24.0,
                      //             width: 24.0,
                      //             child: Theme(
                      //               data: ThemeData(
                      //                 unselectedWidgetColor: AppColorResources
                      //                     .textBlue, // Your color
                      //               ),
                      //               child: Checkbox(
                      //                   activeColor: AppColorResources.textBlue,
                      //                   value: islifeMember,
                      //                   onChanged: checkBox),
                      //             )),
                      //         const SizedBox(width: 10.0),
                      //         const Text(
                      //           AppConst.kYesLifeMember,
                      //         )
                      //       ]),
                      // ),
                      ref.watch(loginloadingProvider)
                          ? const CircularProgressIndicator.adaptive()
                          : ElevatedButton(
                              style: ElevatedButtonTheme.of(context).style,
                              onPressed: () async {
                                await loginFunction();
                              },
                              child: const Text(
                                AppConst.kLogin,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              )),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            height: 1,
                            color: AppColorResources.appSecondaryColor,
                            width: 100,
                          ),
                          Text("OR"),
                          Container(
                            height: 1,
                            color: AppColorResources.appSecondaryColor,
                            width: 100,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: 10,
                      ),
                      Visibility(
                        visible: lifeMemberValue == null,
                        child: ref.watch(loginSignUPloadingProvider)
                            ? const LinearProgressIndicator()
                            : ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            color:
                                                AppColorResources.appBrowColor),
                                        borderRadius: BorderRadius.circular(4)),
                                    backgroundColor: Colors.white),
                                onPressed: () async {
                                  TokenRequestModel auhtModel =
                                      TokenRequestModel(
                                          email: ApiConst.getTokenUserEmail,
                                          password:
                                              ApiConst.getTokenUserPassword);
                                  ref
                                      .read(loginSignUPloadingProvider.notifier)
                                      .update((state) => true);
                                  var connectivityResult = await (Connectivity()
                                      .checkConnectivity());
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
                                                      style: TextStyle(
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                ));
                                          },
                                          transitionDuration:
                                              const Duration(milliseconds: 300),
                                          barrierDismissible: true,
                                          barrierLabel: '',
                                          context: context,
                                          pageBuilder: (context, animation1,
                                              animation2) {
                                            return Container();
                                          });
                                    }
                                    return;
                                  }
                                  if (context.mounted) {
                                    final token = await ref
                                        .read(tokenRepositoryProvider)
                                        .requestTokenRepo(auhtModel);

                                    token.fold((l) async {
                                      ref
                                          .read(loginSignUPloadingProvider
                                              .notifier)
                                          .update((state) => false);

                                      return "Show error snackbar";
                                    }, (r) async {
                                      await ref
                                          .read(countriesListControllerProvider
                                              .notifier)
                                          .getCountries(r.token);
                                      if (context.mounted) {
                                        normalNav(
                                            context, const SignUpScreen());
                                      }
                                      ref
                                          .read(loginSignUPloadingProvider
                                              .notifier)
                                          .update((state) => false);
                                    });
                                  }
                                },
                                child: const Text(
                                  AppConst.kSignUp,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColorResources.appBrowColor),
                                )),
                      ).animate().fade(duration: Duration(seconds: 4)),

                      TextButton(
                          onPressed: () async {
                            normalNav(
                                context,
                                ForgotPasswordScreen(
                                  lifeMemberValue: lifeMemberValue,
                                ));
                          },
                          child: Text(
                            AppConst.kForgotPassword,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: screenW * 0.08,
                      ),
                      const Text(AppConst.kappPoweredBy)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String? validateInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter email or your membership number';
  } else if (value.length < 3) {
    return 'Membership No. must be atleast 3 digits numbers';
  } else if (!isNumeric(value) && !isValidEmail(value)) {
    return 'Please enter email or your m';
  }
  return null;
}

bool isValidEmail(String value) {
  bool valid = RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(value);
  return valid;
}

bool isNumeric(String value) {
  if (value == null) {
    return false;
  }
  return double.tryParse(value) != null;
}
