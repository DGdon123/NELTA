import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/app_const/app_images.dart';
import 'package:nelta/features/auth/presentation/controllers/loading_controller.dart';
import 'package:nelta/features/auth/presentation/singup/sign_up_screen.dart';
import 'package:nelta/features/auth/presentation/widgets/custom_form.dart';
import 'package:nelta/features/profile/data/model/user_models/profile_response_model.dart';
import 'package:nelta/features/profile/data/model/user_models/update_profile_request_model.dart';
import 'package:nelta/features/profile/presentation/controller/user_controllers/update_profile_controller.dart';
import 'package:nelta/features/profile/presentation/controller/user_controllers/user_profile_controller.dart';
import 'package:nelta/utils/form_validation/form_input_validation.dart';

class UpdateProfileScreen extends ConsumerStatefulWidget {
  const UpdateProfileScreen({super.key, required this.data});
  final ProfileResponseModel data;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends ConsumerState<UpdateProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController addressController;
  final formKey = GlobalKey<FormState>();
  bool remberPassword = false;
  late String enrollMentGroupValue;
  late String userTypeGroupValue;
  late String lifeMemberGroupValue;
  //Image
  File? image;
  String imgPath = "";
  String imgString = "";

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(
        source: source,
        imageQuality: 50,
      );
      if (image == null) {
        return;
      } else {
        final imageTempo = File(image.path);
        print(this.image);

        if (mounted)
          setState(() {
            this.image = imageTempo;
          });
      }
    } on PlatformException {
      if (kDebugMode) print("Failed to pick image");
    }
  }

  @override
  void initState() {
    nameController = TextEditingController(text: widget.data.fullName);
    emailController = TextEditingController(text: widget.data.email);
    addressController = TextEditingController(text: widget.data.address);
    enrollMentGroupValue = widget.data.enrollment;
    userTypeGroupValue = widget.data.userType;
    lifeMemberGroupValue = widget.data.lifeMember;
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(lifeMemberGroupValue);

    // final double screenH = MediaQuery.of(context).size.height;
    var textStyle = TextStyle(
        color: AppColorResources.textGrey, fontWeight: FontWeight.bold);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.kappbarUpdateProfile),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    color: AppColorResources.appSecondaryColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    image != null
                        ? CircleAvatar(
                            maxRadius: 40,
                            backgroundColor: Colors.white,
                            backgroundImage: FileImage(File(image!.path)),
                          )
                        : widget.data.photo.isNotEmpty
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    AppImages.imageNetworkPath +
                                        widget.data.photo),
                                maxRadius: 40,
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    AppImages.userPlaceHolderInternet),
                                maxRadius: 40,
                              ),
                    Expanded(
                      child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(elevation: 0),
                          onPressed: () {
                            // Navigator.of(context).restorablePush(_modalBuilder);

                            showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    title: const Text(
                                      'Choose your image',
                                      style: TextStyle(fontFamily: "PS"),
                                    ),
                                    // message: const Text('Message'),
                                    actions: <CupertinoActionSheetAction>[
                                      CupertinoActionSheetAction(
                                        child: const Text(
                                          'Gallery',
                                          style: TextStyle(
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: "PS",
                                              color: CupertinoColors.black),
                                        ),
                                        onPressed: () async {
                                          await pickImage(ImageSource.gallery);
                                          Navigator.pop(context);
                                        },
                                      ),
                                      CupertinoActionSheetAction(
                                        child: const Text(
                                          'Camera',
                                          style: TextStyle(
                                              fontSize: 14,
                                              // fontWeight: FontWeight.bold,
                                              fontFamily: "PS",
                                              color: CupertinoColors.black),
                                        ),
                                        onPressed: () async {
                                          await pickImage(ImageSource.camera);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    ],
                                    cancelButton: CupertinoActionSheetAction(
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.bold,
                                            fontFamily: "PS",
                                            color: CupertinoColors.black),
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  );
                                });
                          },
                          icon: Icon(FontAwesomeIcons.penToSquare),
                          label: Text("Upaload Profile")),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                AppConst.kProfileName,
                style: textStyle,
              ),
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
                validator: (input) => input!.isValidName(input),
              ),
              Text(
                AppConst.kProfileEmail,
                style: textStyle,
              ),
              CustomTextformFormField(
                enabledTextformField: false,
                istextCapitilization: true,
                hintText: AppConst.kEmail,
                isLablerequire: true,
                controller: emailController,
                label: AppConst.kEmail,
                isLableIconrequire: true,
                iconData: Icons.lock_outline,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (input) => input!.isValidEmail(input),
              ),
              Text(
                AppConst.kProfileNAddress,
                style: textStyle,
              ),
              CustomTextformFormField(
                istextCapitilization: true,
                hintText: AppConst.kAddress,
                isLablerequire: true,
                controller: addressController,
                label: AppConst.kAddress,
                isLableIconrequire: true,
                iconData: Icons.lock_outline,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                validator: (input) => input!.isValidName(input),
              ),
              Column(
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
                        groupValue: enrollMentGroupValue,
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
                        groupValue: enrollMentGroupValue,
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
                        groupValue: enrollMentGroupValue,
                        label: AppConst.kLabelUniversity,
                        value: AppConst.kUniversity,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
              Column(
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
                        groupValue: userTypeGroupValue,
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
                        groupValue: userTypeGroupValue,
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
                        groupValue: userTypeGroupValue,
                        label: AppConst.kLabelTrainer,
                        value: AppConst.kTrainer,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              ),
              ref.watch(loginloadingProvider)
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          fixedSize:
                              Size(MediaQuery.of(context).size.width, 35)),
                      onPressed: () async {
                        String? fileName =
                            image == null ? null : image!.path.split('/').last;
                        print(image!.path.split('/').last);
                        final fileData = image == null
                            ? null
                            : await MultipartFile.fromFile(image!.path,
                                filename: fileName);
                        UpdateProfileRestModel update = UpdateProfileRestModel(
                            photo: fileData,
                            address: addressController.text,
                            email: emailController.text,
                            fullName: nameController.text,
                            enrollment: enrollMentGroupValue,
                            userType: userTypeGroupValue,
                            lifeMember: lifeMemberGroupValue);
                        FormData formData = FormData.fromMap(update.toMap());

                        ref
                            .read(loginloadingProvider.notifier)
                            .update((state) => true);
                        await ref
                            .read(updateProfileControllerProvider.notifier)
                            .updateProfileC(formData, context);
                        ref.invalidate(userProfileControllerProvider);
                        ref
                            .read(loginloadingProvider.notifier)
                            .update((state) => false);
                      },
                      child: const Text(
                        AppConst.kButtonUpdate,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
