import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/features/auth/data/repositories/token_repository.dart';
import 'package:nelta/features/auth/presentation/widgets/custom_form.dart';
import 'package:nelta/features/profile/presentation/controller/user_controllers/user_profile_controller.dart';
import 'package:nelta/utils/form_validation/form_input_validation.dart';
import '../../../../common/asyn_widget/asyncvalue_widget.dart';
import '../../../../core/api_const/api_const.dart';
import '../../../../utils/snackbar/custome_snack_bar.dart';
import '../../data/models/signmodel/sign_upmodel.dart';
import '../../data/models/token_model/token_request_model.dart';
import '../controllers/auth/sing_up_controller.dart';
import '../controllers/country/country_controller.dart';
import '../controllers/loading_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController memberIdController = TextEditingController();
  late bool isvisible;
  final formKey = GlobalKey<FormState>();
  bool remberPassword = false;

  String? enrollMentGroupValue;
  String? userTypeGroupValue;
  String? lifeMemberGroupValue;
  String? selectedCountryId;
  @override
  void initState() {
    isvisible = true;
    nameController = TextEditingController();
    addressController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    memberIdController = TextEditingController();
    enrollMentGroupValue = AppConst.kKindergarten;
    userTypeGroupValue = AppConst.kTeacher;
    lifeMemberGroupValue = AppConst.kNo;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    emailController.dispose();
    passwordController.dispose();
    memberIdController.dispose();
    super.dispose();
  }

  checkBox(value) {
    setState(() {});
    remberPassword = value!;
    log(remberPassword.toString());
  }

  toogleVisibility() {
    setState(() {});
    isvisible = !isvisible;
  }

  dismissKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      return currentFocus.unfocus();
    }
  }

  var logger = Logger(
    printer: PrettyPrinter(),
  );
  signUpF() async {
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
      logger.d(memberIdController.text);
      logger.d(selectedCountryId!);
      logger.d(enrollMentGroupValue);
      logger.d(userTypeGroupValue);
      logger.d(lifeMemberGroupValue);
      SignUpRequestModel singUp = SignUpRequestModel(
          member_id: memberIdController.text,
          email: emailController.text,
          password: passwordController.text,
          countryId: selectedCountryId!,
          fcmToken: "s",
          fullName: nameController.text,
          address: addressController.text,
          enrollment: enrollMentGroupValue.toString(),
          userType: userTypeGroupValue.toString(),
          lifeMember: lifeMemberGroupValue.toString());
      ref.read(loginloadingProvider.notifier).update((state) => true);
      if (context.mounted) {
        final token =
            await ref.read(tokenRepositoryProvider).requestTokenRepo(auhtModel);

        return token.fold((l) {
          ref.read(loginloadingProvider.notifier).update((state) => false);
          return showCustomSnackBar("Faild ", context, isError: true);
        }, (r) async {
          await ref.read(signUpControllerProvider.notifier).signUpC(
              signUpRequestModel: singUp, token: r.token, context: context);
          ref.invalidate(userProfileControllerProvider);
          ref.read(loginloadingProvider.notifier).update((state) => false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final countriesList = ref.watch(countriesListControllerProvider);
    final double screenH = MediaQuery.of(context).size.height;
    final double screenW = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: dismissKeyboard,
      child: Form(
        key: formKey,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(AppConst.kregister),
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextformFormField(
                      istextCapitilization: true,
                      hintText: AppConst.kFullName,
                      isLablerequire: true,
                      controller: nameController,
                      label: AppConst.kFullName,
                      isLableIconrequire: true,
                      iconData: Icons.lock_outline,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (input) => input!.isValidName(input)),
                  CustomTextformFormField(
                      hintText: AppConst.kAddress,
                      isLablerequire: true,
                      controller: addressController,
                      label: AppConst.kAddress,
                      isLableIconrequire: true,
                      iconData: Icons.lock_outline,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (input) => input!.isAddressValid(input)),
                  CustomTextformFormField(
                      hintText: AppConst.kEmail,
                      isLablerequire: true,
                      controller: emailController,
                      label: AppConst.kEmail,
                      isLableIconrequire: true,
                      iconData: Icons.lock_outline,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (input) => input!.isValidEmail(input)),
                  CustomTextformFormField(
                      obscureText: isvisible,
                      issuffixIconrequired: IconButton(
                          onPressed: toogleVisibility,
                          icon: Icon(
                            isvisible ? Icons.visibility_off : Icons.visibility,
                            size: 16,
                          )),
                      hintText: AppConst.kPassword,
                      isLablerequire: true,
                      controller: passwordController,
                      label: AppConst.kPassword,
                      isLableIconrequire: true,
                      iconData: Icons.lock_outline,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      validator: (input) => input!.isPasswordValid(input)),
                  SizedBox(
                    height: screenH * 0.01,
                  ),
                  AsyncValueWidget(
                    height: 100,
                    value: countriesList,
                    providerBase: countriesListControllerProvider,
                    data: (data) => Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: 60,
                      child: DropdownButtonFormField(
                          dropdownColor: AppColorResources.bgG,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          // style: GoogleFonts.poppins(fontSize: 13),
                          elevation: 0,
                          validator: (value) =>
                              value == null ? "Please select country" : null,
                          iconSize: 30,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: const Color(0xffF1F1F1),
                              hintStyle: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                              hintText: "Please choose country",
                              // hintStyle: Theme.of(context)
                              //     .textTheme
                              //     .bodySmall,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.5,
                                    // color: Color(0xff575757),
                                    color: Color(0xffF1F1F1)),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.5,
                                    // color: Color(0xff575757),
                                    color: Color(0xffF1F1F1)),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.5,
                                    // color: Color(0xff575757),
                                    color: Color(0xffF1F1F1)),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.5,
                                    // color: Color(0xff575757),
                                    color: Color(0xffF1F1F1)),
                                borderRadius: BorderRadius.circular(4.0),
                              )),
                          items: [
                            ...data.map((e) {
                              return DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.countryName,
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 13),
                                ),
                              );
                            })
                          ],
                          onChanged: (value) {
                            selectedCountryId = value!.id.toString();
                            // ref
                            //     .read(proviceIdProvider.notifier)
                            //     .state = value!.id;
                            log(selectedCountryId.toString());
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConst.kenrollMent,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            LabeledRadio(
                              onChanged: (value) {
                                setState(() {
                                  enrollMentGroupValue = value.toString();
                                });
                              },
                              groupValue: enrollMentGroupValue.toString(),
                              label: AppConst.kLabelKindergarten,
                              value: AppConst.kKindergarten,
                              padding: EdgeInsets.zero,
                            ),
                            LabeledRadio(
                              onChanged: (value) {
                                setState(() {
                                  enrollMentGroupValue = value.toString();
                                });
                              },
                              groupValue: enrollMentGroupValue.toString(),
                              label: AppConst.kLabelSchool,
                              value: AppConst.kSchool,
                              padding: EdgeInsets.zero,
                            ),
                            LabeledRadio(
                              onChanged: (value) {
                                setState(() {
                                  enrollMentGroupValue = value.toString();
                                });
                              },
                              groupValue: enrollMentGroupValue.toString(),
                              label: AppConst.kLabelUniversity,
                              value: AppConst.kUniversity,
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConst.kUserType,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            LabeledRadio(
                              onChanged: (value) {
                                setState(() {
                                  userTypeGroupValue = value.toString();
                                });
                              },
                              groupValue: userTypeGroupValue.toString(),
                              label: AppConst.kLabelTeacher,
                              value: AppConst.kTeacher,
                              padding: EdgeInsets.zero,
                            ),
                            LabeledRadio(
                              onChanged: (value) {
                                setState(() {
                                  userTypeGroupValue = value.toString();
                                });
                              },
                              groupValue: userTypeGroupValue.toString(),
                              label: AppConst.kLabelReacher,
                              value: AppConst.kReacher,
                              padding: EdgeInsets.zero,
                            ),
                            LabeledRadio(
                              onChanged: (value) {
                                setState(() {
                                  userTypeGroupValue = value.toString();
                                });
                              },
                              groupValue: userTypeGroupValue.toString(),
                              label: AppConst.kLabelTrainer,
                              value: AppConst.kTrainer,
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       Text(
                  //         AppConst.kLifeMember,
                  //         style: Theme.of(context)
                  //             .textTheme
                  //             .bodySmall!
                  //             .copyWith(fontWeight: FontWeight.bold),
                  //       ),
                  //       Row(
                  //         children: [
                  //           LabeledRadio(
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 lifeMemberGroupValue = value.toString();
                  //               });
                  //             },
                  //             groupValue: lifeMemberGroupValue,
                  //             label: AppConst.kLYes,
                  //             value: AppConst.kYes,
                  //             padding: EdgeInsets.zero,
                  //           ),
                  //           LabeledRadio(
                  //             onChanged: (value) {
                  //               setState(() {
                  //                 lifeMemberGroupValue = value.toString();
                  //               });
                  //             },
                  //             groupValue: lifeMemberGroupValue,
                  //             label: AppConst.kLNo,
                  //             value: AppConst.kNo,
                  //             padding: EdgeInsets.zero,
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
                  ),
                  // lifeMemberGroupValue == AppConst.kYes
                  //     ? Animate(
                  //         effects: [SlideEffect()],
                  //         child: CustomTextformFormField(
                  //             hintText: AppConst.kMemberID,
                  //             isLablerequire: true,
                  //             controller: memberIdController,
                  //             label: AppConst.kMemberID,
                  //             isLableIconrequire: true,
                  //             keyboardType: TextInputType.number,
                  //             textInputAction: TextInputAction.next,
                  //             validator: (input) =>
                  //                 input!.isMemberIdValid(input)),
                  //       )
                  //     : Text(""),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 24.0,
                              width: 24.0,
                              child: Theme(
                                data: ThemeData(
                                  unselectedWidgetColor:
                                      AppColorResources.textBlue, // Your color
                                ),
                                child: Checkbox(
                                    activeColor: AppColorResources.textBlue,
                                    value: remberPassword,
                                    onChanged: checkBox),
                              )),
                          const SizedBox(width: 10.0),
                          const Text(
                            AppConst.kIgree,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: screenH * 0.02,
                  ),
                  ref.watch(loginloadingProvider)
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : ElevatedButton(
                          // style: Ele
                          style: ElevatedButton.styleFrom(
                              fixedSize: Size(screenW, 0)),
                          onPressed: () async {
                            if (remberPassword == false) {
                              showCustomSnackBar(
                                  "Please agree with Terms and condition",
                                  context,
                                  isError: true);
                            } else {
                              await signUpF();
                            }
                          },
                          child: const Text(
                            AppConst.kSignUp,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LabeledRadio extends StatelessWidget {
  final String label;
  final EdgeInsets padding;
  final String groupValue;
  final String value;
  final Function onChanged;

  const LabeledRadio(
      {super.key,
      required this.label,
      required this.padding,
      required this.groupValue,
      required this.value,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio(
              groupValue: groupValue,
              value: value,
              onChanged: (newValue) {
                onChanged(newValue);
              },
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppColorResources.textGrey),
            ),
          ],
        ),
      ),
    );
  }
}
