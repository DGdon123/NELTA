import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/auth/data/models/login%20model/login_response_model.dart';
import 'package:nelta/features/profile/presentation/controller/location_controllers/get_district_controller.dart';
import 'package:nelta/features/profile/presentation/controller/location_controllers/get_municipality_controller.dart';
import 'package:nelta/features/profile/presentation/controller/location_controllers/get_pradesh_controller.dart';
import 'package:nelta/features/profile/presentation/controller/member_controllers/get_member_profile_controller.dart';
import 'package:nelta/features/profile/presentation/controller/user_controllers/user_profile_controller.dart';
import 'package:nelta/features/profile/presentation/views/member/member_update_profile_screen.dart';

import '../../../../../common/app_const/app_images.dart';

class MemberProfilScreen extends ConsumerStatefulWidget {
  const MemberProfilScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MemberProfilScreenState();
}

class _MemberProfilScreenState extends ConsumerState<MemberProfilScreen> {
  String name = "";
  String id = "";
  userDataLoad() async {
    final String data = await DbClient().getData(dbKey: "userData");
    final LoginResponseModel loginResponseModel =
        LoginResponseModel.fromJson(data);
    setState(() {
      id = loginResponseModel.id.toString();
    });
  }

  @override
  void initState() {
    userDataLoad();
    super.initState();
  }

  @override
  void deactivate() {
    log("profile deactivate");
    super.deactivate();
  }

  @override
  void dispose() {
    log('profile dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final districtData = ref.watch(districtController);
    final memberProfile = ref.watch(getmemberProfileControllerProvider);
    return Scaffold(
      backgroundColor: Color(0xffF2F2F7),
      appBar: AppBar(
        actions: const [
          // Expanded(
          //   child: AsyncValueWidget(
          //       value: userProfile,
          //       data: (data) => IconButton(
          //             icon: const Icon(FontAwesomeIcons.penToSquare),
          //             onPressed: () =>
          //                 normalNav(context, UpdateProfileScreen(data: data)),
          //           ),
          //       providerBase: userProfileControllerProvider(id.toString())),
          // )
        ],
        title: const Text(AppConst.kappBarProfile),
      ),
      body: AsyncValueWidget(
          isList: true,
          listCount: 4,
          value: memberProfile,
          data: (data) {
            // log(data.provinceId);
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          CachedNetworkImage(
                            // width: 50,
                            // height: 50,
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: NetworkImage(
                                  AppImages.imageNetworkPath + data.photo),
                              maxRadius: 30,
                            ),
                            imageUrl: AppImages.imageNetworkPath + data.photo,
                            placeholder: (context, url) => CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  AppImages.userPlaceHolderNoInternet),
                              maxRadius: 30,
                            ),
                            errorWidget: (context, url, error) => CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage: AssetImage(
                                  AppImages.userPlaceHolderNoInternet),
                              maxRadius: 30,
                            ),
                          ),
                          // CircleAvatar(
                          //   backgroundColor: Colors.white,
                          //   backgroundImage: NetworkImage(
                          //       AppImages.imageNetworkPath + data.photo),
                          //   maxRadius: 30,
                          // ),
                          Text(
                            data.fname + " " + data.lname,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (ctx) => MemberProfileUpdateScreen(
                                      memberProfileResponseModel: data,
                                    ),
                                  ),
                                );
                                // normalNav(
                                //     context,
                                //     MemberProfileUpdateScreen(
                                //       memberProfileResponseModel: data,
                                //     ));
                              },
                              icon: Icon(FontAwesomeIcons.penToSquare))
                        ],
                      ),
                    ).animate().scaleY(),
                    const SizedBox(
                      height: 10,
                    ),
                    if (data.associateMembershipNumber.isNotEmpty)
                      CupertinoListTile(
                        backgroundColor: Colors.white,
                        leading: Icon(CupertinoIcons.news),
                        title: Text("Associate membership number",
                            style: GoogleFonts.poppins(fontSize: 14)),
                        subtitle: Text(data.associateMembershipNumber,
                            style: GoogleFonts.poppins()),
                      ),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    // CupertinoListTile(
                    //   leading: Icon(CupertinoIcons.waveform),
                    //   backgroundColor: Colors.white,
                    //   title: Text("Enrollment", style: GoogleFonts.poppins()),
                    //   subtitle:
                    //       Text(data.address, style: GoogleFonts.poppins()),
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.selection_pin_in_out),
                      backgroundColor: Colors.white,
                      title: Text("Membership Type",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      subtitle: Text(data.membershipType,
                          style: GoogleFonts.poppins()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CupertinoListTile(
                      backgroundColor: Colors.white,
                      leading: Icon(CupertinoIcons.home),
                      title: Text("Address",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      subtitle:
                          Text(data.address, style: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.envelope),
                      backgroundColor: Colors.white,
                      title: Text("Email",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      subtitle: Text(data.email, style: GoogleFonts.poppins()),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.hourglass),
                      backgroundColor: Colors.white,
                      title: Text("Status",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      subtitle: Text(data.status, style: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.phone),
                      backgroundColor: Colors.white,
                      title: Text("Contact",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      subtitle:
                          Text(data.phoneNo, style: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    AsyncValueWidget(
                        height: 40,
                        value: ref.watch(pradeshController),
                        data: (data) {
                          return CupertinoListTile(
                            leading: Icon(CupertinoIcons.placemark),
                            backgroundColor: Colors.white,
                            title: Text("Province",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            subtitle: Text(
                                data.pradesh_name.isEmpty
                                    ? "-"
                                    : data.pradesh_name,
                                style: GoogleFonts.poppins()),
                          );
                        },
                        providerBase: pradeshController),
                    SizedBox(
                      height: 10,
                    ),
                    AsyncValueWidget(
                        height: 40,
                        value: districtData,
                        data: (data) {
                          // log(data.toString());
                          return CupertinoListTile(
                            leading: Icon(CupertinoIcons.placemark),
                            backgroundColor: Colors.white,
                            title: Text("District",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            subtitle: Text(
                                data.nepaliName.isEmpty ? "-" : data.nepaliName,
                                style: GoogleFonts.poppins()),
                          );
                        },
                        providerBase: districtController),
                    SizedBox(
                      height: 10,
                    ),
                    AsyncValueWidget(
                        height: 40,
                        value: ref.watch(municipalityControllerProvider),
                        data: (data) {
                          return CupertinoListTile(
                            leading: Icon(CupertinoIcons.placemark),
                            backgroundColor: Colors.white,
                            title: Text("Municipality",
                                style: GoogleFonts.poppins(fontSize: 14)),
                            subtitle: Text(
                                data.muniName.isEmpty ? "-" : data.muniName,
                                style: GoogleFonts.poppins()),
                          );
                        },
                        providerBase: municipalityControllerProvider),

                    SizedBox(
                      height: 10,
                    ),

                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.placemark),
                      backgroundColor: Colors.white,
                      title: Text("Ward number",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      subtitle: Text(data.ward_no.isEmpty ? "-" : data.ward_no,
                          style: GoogleFonts.poppins()),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    CupertinoListTile(
                      leading: Icon(CupertinoIcons.person),
                      backgroundColor: Colors.white,
                      title: Text("Gender",
                          style: GoogleFonts.poppins(fontSize: 14)),
                      subtitle: Text(data.Gender.isEmpty ? "-" : data.Gender,
                          style: GoogleFonts.poppins()),
                    ),
                  ],
                ),
              ),
            );
          },
          providerBase: userProfileControllerProvider),
    );
  }
}
