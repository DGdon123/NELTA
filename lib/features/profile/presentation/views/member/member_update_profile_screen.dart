// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nelta/common/app_const/app_color.dart';

import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/app_const/app_images.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/features/auth/presentation/controllers/loading_controller.dart';
import 'package:nelta/features/auth/presentation/widgets/custom_form.dart';
import 'package:nelta/features/profile/data/model/member_models/member_profile_model.dart';
import 'package:nelta/features/profile/presentation/controller/location_controllers/address_list_controllers/district_list_controller.dart';
import 'package:nelta/features/profile/presentation/controller/location_controllers/address_list_controllers/municipality_list_controller.dart';
import 'package:nelta/features/profile/presentation/controller/location_controllers/address_list_controllers/pradesh_list_controller.dart';
import 'package:nelta/utils/form_validation/form_input_validation.dart';

import '../../controller/member_controllers/get_member_profile_controller.dart';
import '../../controller/member_controllers/member_update_controller.dart';

class District {
  final String name;
  int value;
  District({
    required this.name,
    required this.value,
  });

  @override
  bool operator ==(covariant District other) {
    if (identical(this, other)) return true;

    return other.name == name && other.value == value;
  }

  @override
  int get hashCode => name.hashCode ^ value.hashCode;
}

class MemberProfileUpdateScreen extends ConsumerStatefulWidget {
  const MemberProfileUpdateScreen(
      {super.key, required this.memberProfileResponseModel});
  final MemberProfileResponseModel memberProfileResponseModel;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MemberProfileUpdateScreenState();
}

class _MemberProfileUpdateScreenState
    extends ConsumerState<MemberProfileUpdateScreen> {
  late TextEditingController wordController;
  late TextEditingController fnameController;
  late TextEditingController lnameController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  late String selectedPradeshId;
  late String selectedDistrictId;
  late String selectedMunicipalityId;
  late String selectedGender;
  District defaultValue = District(name: "Please select", value: 0);
  final GlobalKey<FormState> memberprofileupdateFormKey =
      GlobalKey<FormState>();
  List<District> testData = [
    District(name: "Please select", value: 0),
    District(name: "ktm", value: 23),
    District(name: "bhakt", value: 32),
  ];

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
        print(imageTempo);

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
    wordController =
        TextEditingController(text: widget.memberProfileResponseModel.ward_no);
    selectedGender = widget.memberProfileResponseModel.Gender;
    selectedMunicipalityId = widget.memberProfileResponseModel.muniId;
    selectedDistrictId = widget.memberProfileResponseModel.districtId;
    selectedPradeshId = widget.memberProfileResponseModel.provinceId;
    fnameController =
        TextEditingController(text: widget.memberProfileResponseModel.fname);
    lnameController =
        TextEditingController(text: widget.memberProfileResponseModel.lname);
    phoneController =
        TextEditingController(text: widget.memberProfileResponseModel.phoneNo);
    addressController =
        TextEditingController(text: widget.memberProfileResponseModel.address);
    super.initState();
  }

  @override
  void dispose() {
    fnameController.clear();
    lnameController.clear();
    // log('edit dispose');
    super.dispose();
  }

  @override
  void deactivate() {
    // log('edit deactivet');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    log(selectedDistrictId.toString());
    var textStyle = GoogleFonts.poppins(fontWeight: FontWeight.w500);
    return Scaffold(
      appBar: AppBar(
        title: Text("Update Member Profile"),
      ),
      body: Form(
        key: memberprofileupdateFormKey,
        child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 14),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: AppColorResources.bgG,
                              spreadRadius: 0,
                              offset: Offset(
                                1,
                                2,
                              ))
                        ],
                        color: CupertinoColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        image != null
                            ? CircleAvatar(
                                maxRadius: 40,
                                backgroundColor: Colors.white,
                                backgroundImage: FileImage(File(image!.path)),
                              )
                            // Image.file(
                            //     image!,
                            //     height: 10,
                            //     width: 10,
                            //   )
                            : CachedNetworkImage(
                                // width: 50,
                                // height: 50,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(AppImages
                                          .imageNetworkPath +
                                      widget.memberProfileResponseModel.photo),
                                  maxRadius: 30,
                                ),
                                imageUrl: AppImages.imageNetworkPath +
                                    widget.memberProfileResponseModel.photo,
                                placeholder: (context, url) => CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                      AppImages.userPlaceHolderNoInternet),
                                  maxRadius: 30,
                                ),
                                errorWidget: (context, url, error) =>
                                    CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: AssetImage(
                                      AppImages.userPlaceHolderNoInternet),
                                  maxRadius: 30,
                                ),
                              ),
                        // widget.memberProfileResponseModel.photo.isNotEmpty
                        //     ? CircleAvatar(
                        //         backgroundColor: Colors.white,
                        //         backgroundImage: NetworkImage(
                        //             AppImages.imageNetworkPath +
                        //                 widget.memberProfileResponseModel
                        //                     .photo),
                        //         maxRadius: 40,
                        //       )
                        //     : CircleAvatar(
                        //         backgroundColor: Colors.white,
                        //         backgroundImage: NetworkImage(
                        //             AppImages.userPlaceHolderInternet),
                        //         maxRadius: 40,
                        //       ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColorResources.bgG,
                                elevation: 0,
                                fixedSize: Size(200, 32)),
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
                                            await pickImage(
                                                ImageSource.gallery);
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

                              // showModalBottomSheet(
                              //     shape: const RoundedRectangleBorder(
                              //       borderRadius: BorderRadius.vertical(
                              //         top: Radius.circular(25.0),
                              //       ),
                              //     ),
                              //     // elevation: 0,
                              //     // barrierColor: Colors.black.withOpacity(0.9),
                              //     // backgroundColor: Colors.transparent,
                              //     context: context,
                              //     builder: (context) {
                              //       return Text("data");
                              //     });
                            },
                            icon: Icon(FontAwesomeIcons.penToSquare,
                                color: AppColorResources.appSecondaryColor),
                            label: Text(
                              "Upload Image",
                              style: TextStyle(
                                  color: AppColorResources.appSecondaryColor),
                            ))
                      ],
                    ),
                  ),
                  Text(AppConst.kProfileName, style: textStyle),
                  CustomTextformFormField(
                    istextCapitilization: true,
                    hintText: AppConst.kFirstName,
                    isLablerequire: true,
                    controller: fnameController,
                    label: AppConst.kFullName,
                    isLableIconrequire: true,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (input) => input!.isFirtNameValid(input),
                  ),
                  Text(AppConst.KlastName, style: textStyle),
                  CustomTextformFormField(
                    istextCapitilization: true,
                    hintText: AppConst.KlastName,
                    isLablerequire: true,
                    controller: lnameController,
                    label: AppConst.kFullName,
                    isLableIconrequire: true,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (input) => input!.isLastNameValid(input),
                  ),
                  Text(AppConst.KphoneNumber, style: textStyle),
                  CustomTextformFormField(
                    ismaxLength: true,
                    istextCapitilization: true,
                    hintText: AppConst.KphoneNumber,
                    isLablerequire: true,
                    controller: phoneController,
                    isLableIconrequire: true,
                    iconData: Icons.lock_outline,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (input) => input!.isPhoneValidate(input),
                  ),
                  Text("Gender", style: textStyle),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: DropdownButtonFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null) {
                            return "Please select gender";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xffF1F1F1),
                          border: InputBorder.none,
                        ),
                        value: selectedGender == "" ? null : selectedGender,
                        items: <String>[
                          'Male',
                          'Female',
                          'Other',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (mounted) setState(() {});
                          selectedGender = value!;
                        },
                        hint: Text(
                          'Please select gender',
                          style: GoogleFonts.poppins(fontSize: 14),
                        ),
                      )),
                  Text(AppConst.kAddress, style: textStyle),
                  CustomTextformFormField(
                    istextCapitilization: true,
                    hintText: AppConst.kAddress,
                    isLablerequire: true,
                    controller: addressController,
                    label: AppConst.kFullName,
                    isLableIconrequire: true,
                    keyboardType: TextInputType.name,
                    textInputAction: TextInputAction.next,
                    validator: (input) => input!.iswordNumberValid(input),
                  ),
                  Text(AppConst.kWord, style: textStyle),
                  CustomTextformFormField(
                    istextCapitilization: true,
                    hintText: AppConst.kWord,
                    isLablerequire: true,
                    controller: wordController,
                    isLableIconrequire: true,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    validator: (input) => input!.isWordNumber(input),
                  ),
                  Text(AppConst.kProvince, style: textStyle),
                  AsyncValueWidget(
                      height: 40,
                      value: ref.watch(pradeshListControllerProvider),
                      data: (data) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: DropdownButtonFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                return "Please select Province";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              focusedErrorBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0,
                                      color: CupertinoColors.systemCyan),
                                  borderRadius: BorderRadius.circular(10)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0,
                                      color:
                                          CupertinoColors.lightBackgroundGray),
                                  borderRadius: BorderRadius.circular(10)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 0,
                                      color:
                                          CupertinoColors.lightBackgroundGray),
                                  borderRadius: BorderRadius.circular(10)),
                              filled: true,
                              fillColor: Color(0xffF1F1F1),
                              border: InputBorder.none,
                            ),
                            value: selectedPradeshId == "0"
                                ? null
                                : selectedPradeshId,
                            items: data.map((pradesh) {
                              // log(pradesh.pradesh_name);
                              return DropdownMenuItem(
                                value: pradesh.id,
                                child: Text(
                                  pradesh.pradesh_name,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (mounted)
                                setState(() {
                                  selectedPradeshId = value!;
                                  selectedDistrictId = "0";
                                });
                              // log(value.toString() + "prV");
                              // log(selectedPradeshId.toString());
                              // do something with the selected value
                            },
                            hint: Text(
                              'Please select Province',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          ),
                        );
                      },
                      providerBase: pradeshListControllerProvider),
                  Text(AppConst.kDistrict, style: textStyle),

                  // DropdownButtonFormField<int>(
                  //     value: defaultValue.value,
                  //     items: [
                  //       ...testData.map(
                  //         (e) => DropdownMenuItem(
                  //           child: Text(e.name),
                  //           value: e.value,
                  //         ),
                  //       ),
                  //     ],
                  //     onChanged: (value) {
                  //       setState(() {
                  //         defaultValue.value = value!;
                  //       });
                  //     }),

                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AsyncValueWidget(
                        height: 40,
                        value: ref.watch(districListControllerProvider(
                            selectedPradeshId.toString())),
                        data: (data) {
                          return DropdownButtonFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                return "Please select district";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF1F1F1),
                              border: InputBorder.none,
                            ),
                            value: selectedDistrictId == "0"
                                ? null
                                : selectedDistrictId,
                            items: data.map((district) {
                              return DropdownMenuItem(
                                value: district.id,
                                child: Text(
                                  district.nepaliName,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (mounted) setState(() {});
                              selectedDistrictId = value!;
                              selectedMunicipalityId = "0";
                            },
                            hint: Text(
                              'Please select district',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          );
                        },
                        providerBase: districListControllerProvider(
                            selectedPradeshId.toString())),
                  ),

                  Text(AppConst.kMunicipality, style: textStyle),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AsyncValueWidget(
                        height: 40,
                        value: ref.watch(municipalityListControllerProvider(
                            selectedDistrictId.toString())),
                        data: (data) {
                          return DropdownButtonFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null) {
                                return "Please select municipality";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xffF1F1F1),
                              border: InputBorder.none,
                            ),
                            value: selectedMunicipalityId == "0"
                                ? null
                                : selectedMunicipalityId,
                            items: data.map((muni) {
                              return DropdownMenuItem(
                                value: muni.id,
                                child: Text(
                                  muni.muniName,
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              if (mounted) setState(() {});
                              selectedMunicipalityId = value!;
                            },
                            hint: Text(
                              'Please select municipality',
                              style: GoogleFonts.poppins(fontSize: 14),
                            ),
                          );
                        },
                        providerBase: municipalityListControllerProvider(
                            selectedDistrictId.toString())),
                  ),

                  // Text(AppConst.kMunicipality, style: textStyle),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: CupertinoTheme(
                  //     data: CupertinoThemeData(
                  //       textTheme: CupertinoTextThemeData(
                  //         pickerTextStyle: TextStyle(
                  //           fontSize: 14,
                  //           color: CupertinoColors.black,
                  //         ),
                  //       ),
                  //     ),
                  //     child: DropdownButtonFormField<String>(
                  //       hint: Text('Select a gender'),
                  //       decoration: InputDecoration(
                  //         filled: true,
                  //         fillColor: Color(0xffF1F1F1),
                  //         border: InputBorder.none,
                  //       ),
                  //       value: selectedGender == "" ? null : selectedGender,
                  //       onChanged: (newValue) {
                  //         setState(() {
                  //           selectedGender = newValue!;
                  //         });
                  //       },
                  //       items: <String>[
                  //         'Male',
                  //         'Female',
                  //         'Other',
                  //       ].map<DropdownMenuItem<String>>((String value) {
                  //         return DropdownMenuItem<String>(
                  //           value: value,
                  //           child: Text(value),
                  //         );
                  //       }).toList(),
                  //     ),
                  //   ),
                  // ),
                  ref.watch(loadingMemberProfileUpdateProvider)
                      ? const Center(
                          child: CircularProgressIndicator.adaptive())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 35)),
                          onPressed: () async {
                            var connectivityResult =
                                await (Connectivity().checkConnectivity());
                            if (memberprofileupdateFormKey.currentState!
                                .validate()) {
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
                              String? fileName = image == null
                                  ? null
                                  : image!.path.split('/').last;

                              // log(fileName + "image");
                              final fileData = image == null
                                  ? null
                                  : await MultipartFile.fromFile(image!.path,
                                      filename: fileName);
                              FormData formData = FormData.fromMap({
                                "province_id": selectedPradeshId,
                                "district_id": selectedDistrictId,
                                "muni_id": selectedMunicipalityId,
                                "phone_no": phoneController.text,
                                "fname": fnameController.text,
                                "lname": lnameController.text,
                                "address": addressController.text,
                                "ward_no": wordController.text,
                                "Gender": selectedGender,
                                "photo": fileData,
                              });

                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);

                              if (!currentFocus.hasPrimaryFocus) {
                                currentFocus.unfocus();
                              }

                              // final memberProfile = await ref
                              //     .read(profileRepositoryProvider)
                              //     .updateMemberProfileFormDataRepo(formData);
                              // memberProfile.fold((l) async {
                              //   await ref
                              //       .read(
                              //           loadingMemberProfileUpdateProvider.notifier)
                              //       .update((state) => false);

                              //   showCustomSnackBar(l.message, context,
                              //       isError: true);
                              // }, (r) async {
                              //   showCustomSnackBar(r.success, context,
                              //       isError: false);

                              //   await ref
                              //       .read(
                              //           loadingMemberProfileUpdateProvider.notifier)
                              //       .update((state) => false);
                              //   normalNav(context, Dashboard());
                              // });
                              ref
                                  .read(loadingMemberProfileUpdateProvider
                                      .notifier)
                                  .update((state) => true);
                              await ref
                                  .read(updatememberProfileControllerProvider2
                                      .notifier)
                                  .updateMemberProfileC2(formData, context);
                              ref.invalidate(
                                  getmemberProfileControllerProvider);
                              // ref.refresh(provider)  ref.invalidate(districtController);

                              //   ref.invalidate(municipalityControllerProvider);

                              //   ref.invalidate(pradeshController);

                              // await ref
                              //     .refresh(getmemberProfileControllerProvider);
                              // await ref.refresh(districtController);
                              // await ref.refresh(municipalityControllerProvider);
                              // await ref.refresh(pradeshController);
                              ref
                                  .read(loadingMemberProfileUpdateProvider
                                      .notifier)
                                  .update((state) => false);
                              // ref.invalidate(municipalityControllerProvider);
                            }

                            // ref.invalidate(getmemberProfileControllerProvider);
                            // ref.invalidate(pradeshController);
                            // ref.invalidate(districtController);
                            // ref.invalidate(loginloadingProvider);
                            // ref.invalidate(dbClientProvider);

                            // ref
                            //     .read(loadingMemberProfileUpdateProvider.notifier)
                            //     .update((state) => false);
                          },
                          child: const Text(
                            AppConst.kButtonUpdate,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                ],
              ),
            )),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: CupertinoColors.systemGrey2,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              pickerTextStyle: TextStyle(
                fontSize: 14,
                color: CupertinoColors.black,
              ),
            ),
          ),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              border: InputBorder.none,
              isDense: true,
            ),
            value: dropdownValue,
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue;
              });
            },
            items: <String>[
              'Option 1',
              'Option 2',
              'Option 3',
              'Option 4',
              'Option 5'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class MyAvatar extends StatelessWidget {
  final String imagePath;
  final double radius;

  const MyAvatar({required this.imagePath, required this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: FileImage(File(imagePath)),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
