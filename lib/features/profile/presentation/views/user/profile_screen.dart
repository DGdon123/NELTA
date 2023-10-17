import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/auth/data/models/login%20model/login_response_model.dart';
import 'package:nelta/features/profile/presentation/controller/user_controllers/user_profile_controller.dart';
import 'package:nelta/features/profile/presentation/views/user/update_profile.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';

import '../../../../../common/app_const/app_images.dart';

class ProfilScreen extends ConsumerStatefulWidget {
  const ProfilScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends ConsumerState<ProfilScreen> {
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
  Widget build(BuildContext context) {
    final userProfile = ref.watch(userProfileControllerProvider);
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
          value: userProfile,
          data: (data) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                          child: Column(
                        children: [
                          data.photo.isNotEmpty
                              ? CircleAvatar(
                                  backgroundColor: Colors.white,
                                  backgroundImage: data.photo !=
                                          AppImages.userPlaceHolderInternet
                                      ? NetworkImage(
                                          AppImages.imageNetworkPath +
                                              data.photo)
                                      : NetworkImage(data.photo),
                                  maxRadius: 40,
                                )
                              : CircleAvatar(
                                  backgroundColor: Colors.white,
                                  maxRadius: 40,
                                  backgroundImage: NetworkImage(
                                      AppImages.userPlaceHolderInternet)),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            data.fullName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
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
                        title: Text("Enrollment",
                            style: GoogleFonts.poppins(fontSize: 14)),
                        subtitle:
                            Text(data.enrollment, style: GoogleFonts.poppins()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoListTile(
                        leading: Icon(CupertinoIcons.envelope),
                        backgroundColor: Colors.white,
                        title: Text("Email",
                            style: GoogleFonts.poppins(fontSize: 14)),
                        subtitle:
                            Text(data.email, style: GoogleFonts.poppins()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoListTile(
                        leading: Icon(CupertinoIcons.person),
                        backgroundColor: Colors.white,
                        title: Text("User Type",
                            style: GoogleFonts.poppins(fontSize: 14)),
                        subtitle:
                            Text(data.userType, style: GoogleFonts.poppins()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CupertinoListTile(
                        leading: Icon(CupertinoIcons.hourglass),
                        backgroundColor: Colors.white,
                        title: Text("Life member",
                            style: GoogleFonts.poppins(fontSize: 14)),
                        subtitle:
                            Text(data.lifeMember, style: GoogleFonts.poppins()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // ListTile(
                      //   shape: RoundedRectangleBorder(
                      //     side: BorderSide.none,
                      //     borderRadius: BorderRadius.circular(4),
                      //   ),
                      //   leading: const Text(AppConst.kProfileName),
                      //   title: Text(data.fullName),
                      // ),
                      // ListTile(
                      //   leading: const Text(AppConst.kProfileNAddress),
                      //   title: Text(data.address),
                      // ),
                      // ListTile(
                      //   leading: const Text(AppConst.kProfileEnrollment),
                      //   title: Text(data.enrollment),
                      // ),
                      // ListTile(
                      //   leading: const Text(AppConst.kProfileEmail),
                      //   title: Text(data.email),
                      // ),
                      // ListTile(
                      //   leading: const Text(AppConst.kProfileUsertype),
                      //   title: Text(data.userType),
                      // ),
                      // ListTile(
                      //   leading: const Text(AppConst.kProfileLifeMember),
                      //   title: Text(data.lifeMember),
                      // ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              fixedSize:
                                  Size(MediaQuery.of(context).size.width, 35)),
                          onPressed: () {
                            normalNav(context, UpdateProfileScreen(data: data));
                          },
                          icon: const Icon(FontAwesomeIcons.penToSquare),
                          label: const Text(
                            AppConst.kButtonEdit,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
              ),
          providerBase: userProfileControllerProvider),
    );
  }
}
