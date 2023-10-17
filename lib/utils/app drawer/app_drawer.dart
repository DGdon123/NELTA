import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/app_const/app_images.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/about_developer/about_developer_screen.dart';
import 'package:nelta/features/about_nelta/presentation/about_neltascreen.dart';
import 'package:nelta/features/activity/presentation/activity_screen.dart';
import 'package:nelta/features/auth/presentation/controllers/change_password/presentation/change_password_screen.dart';
import 'package:nelta/features/auth/presentation/controllers/token/token_request_controller.dart';
import 'package:nelta/features/branch/branch_screen.dart';
import 'package:nelta/features/conference/presentation/conference/conference_screen.dart';
import 'package:nelta/features/contact_us/presentation/contact_us_screen.dart.dart';
import 'package:nelta/features/events/presentation/event_screen.dart';
import 'package:nelta/features/mou_partner/presentation/mou_partner_screen.dart';
import 'package:nelta/features/notice/presentation/notices_screen.dart';
import 'package:nelta/features/profile/presentation/controller/location_controllers/get_municipality_controller.dart';
import 'package:nelta/features/profile/presentation/controller/member_controllers/get_member_profile_controller.dart';
import 'package:nelta/features/profile/presentation/controller/user_controllers/user_profile_controller.dart';
import 'package:nelta/features/profile/presentation/views/member/member_profile_screen.dart';
import 'package:nelta/features/profile/presentation/views/user/profile_screen.dart';
import 'package:nelta/features/resources/presentation/views/resouces_list_screen.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import '../../common/asyn_widget/asyncvalue_widget.dart';
import '../../features/profile/presentation/controller/location_controllers/get_district_controller.dart';
import '../../features/profile/presentation/controller/location_controllers/get_pradesh_controller.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  logOutF() async {
    await ref.read(tokenControllerProvider.notifier).logout(context);
  }

  String isLifeMember = "";
  userDataLoad() async {
    final String lifeMember = await DbClient().getData(dbKey: "lifeMember");

    print(lifeMember + "sdd");
    if (mounted)
      setState(() {
        isLifeMember = lifeMember;
      });
  }

  @override
  void initState() {
    userDataLoad();
    super.initState();
  }
  // String isLifeMember = "";
  // late Future<String?> userDataFuture = Future.value(null);

  // Future<String> getUserData() async {
  //   try {
  //     final String lifeMember = await DbClient().getData(dbKey: "lifeMember");
  //     return lifeMember;
  //   } catch (e) {
  //     print("Error fetching user data: $e");
  //     return "";
  //   }
  // }

  // @override
  // void initState() {
  //   userDataFuture = getUserData();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final isLifeMemberp = ref.watch(islifeMemberProviderProvider);
    double screenW = MediaQuery.of(context).size.width;
    return Drawer(
      width: screenW * 0.74,
      backgroundColor: Colors.white,
      child: ListView(
        shrinkWrap: true,
        children: [
          // Text(email),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.arrow_back_ios_new)),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          DrawerProfileCard(
            isLifeMember: isLifeMember,
          ),
          // isLifeMember == true ? DrawerProfileCard() : Text("data"),
          // Container(
          //   height: screenW * 0.3,
          //   padding: const EdgeInsets.symmetric(vertical: 20),
          //   // margin: const EdgeInsets.symmetric(horizontal: 10),
          //   decoration: const BoxDecoration(
          //     // borderRadius: BorderRadius.circular(10),
          //     color: AppColorResources.appPrimaryColor,
          //   ),
          //   child: Image.asset(
          //     AppImages.appLogo,
          //   ),
          // ),

          DrawerItemWidget(
              drawerLabel: AppConst.kappBarHome,
              iconData: FontAwesomeIcons.house,
              onTap: () => Navigator.pop(context)),
          DrawerItemWidget(
              drawerLabel: AppConst.kkappBarAbout,
              iconData: FontAwesomeIcons.addressCard,
              onTap: () => normalNav(context, const AboutNeltaScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarActivities,
              iconData: FontAwesomeIcons.chartLine,
              onTap: () => normalNav(context, const ActivityListScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarPartner,
              iconData: FontAwesomeIcons.handshake,
              onTap: () => normalNav(context, const MouPartnerScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarbranches,
              iconData: FontAwesomeIcons.codeBranch,
              onTap: () => normalNav(context, const BranchListScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarContactUs,
              iconData: FontAwesomeIcons.addressBook,
              onTap: () => normalNav(context, const ContactUSScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarConference,
              iconData: FontAwesomeIcons.usersLine,
              onTap: () => normalNav(context, const ComferenceScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarResources,
              iconData: FontAwesomeIcons.folderOpen,
              onTap: () => normalNav(context, const ResourcesListScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarEvents,
              iconData: FontAwesomeIcons.calendarWeek,
              onTap: () => normalNav(context, const EventListScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarNotice,
              iconData: FontAwesomeIcons.noteSticky,
              onTap: () => normalNav(context, const NoticeListScreen())),
          // isLifeMember == "true"
          //     ? DrawerItemWidget(
          //         drawerLabel: AppConst.kappBarUserProfile,
          //         iconData: FontAwesomeIcons.user,
          //         onTap: () => normalNav(context, const ProfilScreen()))
          //     : DrawerItemWidget(
          //         drawerLabel: "Member Profile",
          //         iconData: FontAwesomeIcons.user,
          //         onTap: () => normalNav(context, const ProfilScreen())),
          isLifeMember == "true"
              ? DrawerItemWidget(
                  drawerLabel: "Member Profile",
                  iconData: FontAwesomeIcons.user,
                  onTap: () async {
                    await ref.refresh(pradeshController);
                    await ref.refresh(districtController);
                    await ref.refresh(municipalityControllerProvider);
                    normalNav(context, const MemberProfilScreen());
                  })
              : DrawerItemWidget(
                  drawerLabel: AppConst.kappBarUserProfile,
                  iconData: FontAwesomeIcons.user,
                  onTap: () => normalNav(context, const ProfilScreen())),

          DrawerItemWidget(
              drawerLabel: AppConst.kappBarChangePassword,
              iconData: FontAwesomeIcons.lock,
              onTap: () => normalNav(context, const ChangePasswordScreen())),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarLogout,
              iconData: FontAwesomeIcons.rightFromBracket,
              onTap: () async {
                // Navigator.pop(context);
                // showAboutDialog(context: context);

                await logOutF();
              }),
          DrawerItemWidget(
              drawerLabel: AppConst.kappBarAbputDeveloper,
              iconData: FontAwesomeIcons.code,
              onTap: () => normalNav(context, const AboutDeveloperScreen())),
        ],
      ),
    );
  }
}

// class AppDrawer extends ConsumerWidget {
//   const AppDrawer({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     logOutF() async {
//       await ref.read(tokenControllerProvider.notifier).logout(context);
//     }

//     double screenW = MediaQuery.of(context).size.width;
//     // double screenH = MediaQuery.of(context).size.height;
//     return Drawer(
//       width: screenW * 0.7,
//       backgroundColor: Colors.white,
//       child: ListView(
//         shrinkWrap: true,
//         children: [
//           // Text(data),
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: const EdgeInsets.only(right: 30),
//               child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(Icons.arrow_back_ios_new)),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           const DrawerProfileCard(),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarHome,
//               iconData: FontAwesomeIcons.house,
//               onTap: () => Navigator.pop(context)),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kkappBarAbout,
//               iconData: FontAwesomeIcons.addressCard,
//               onTap: () => normalNav(context, const AboutNeltaScreen())),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarActivities,
//               iconData: FontAwesomeIcons.chartLine,
//               onTap: () => normalNav(context, const ActivityListScreen())),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarPartner,
//               iconData: FontAwesomeIcons.handshake,
//               onTap: () => normalNav(context, const MouPartnerScreen())),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarbranches,
//               iconData: FontAwesomeIcons.codeBranch,
//               onTap: () => normalNav(context, const BranchListScreen())),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarContactUs,
//               iconData: FontAwesomeIcons.addressBook,
//               onTap: () => normalNav(context, const ContactUSScreen())),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarConference,
//               iconData: FontAwesomeIcons.usersLine,
//               onTap: () => normalNav(context, const ComferenceScreen())),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarResources,
//               iconData: FontAwesomeIcons.folderOpen,
//               onTap: () => Navigator.pop(context)),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarEvents,
//               iconData: FontAwesomeIcons.calendarWeek,
//               onTap: () => normalNav(context, const EventListScreen())),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarNotice,
//               iconData: FontAwesomeIcons.noteSticky,
//               onTap: () => normalNav(context, const NoticeListScreen())),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarUserProfile,
//               iconData: FontAwesomeIcons.user,
//               onTap: () => Navigator.pop(context)),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarLogout,
//               iconData: FontAwesomeIcons.rightFromBracket,
//               onTap: () async {
//                 return logOutF();
//               }),
//           DrawerItemWidget(
//               drawerLabel: AppConst.kappBarAbputDeveloper,
//               iconData: FontAwesomeIcons.code,
//               onTap: () => Navigator.pop(context)),
//         ],
//       ),
//     );
//   }
// }
class DrawerProfileCard extends ConsumerStatefulWidget {
  const DrawerProfileCard({super.key, required this.isLifeMember});
  final String isLifeMember;
  @override
  ConsumerState<DrawerProfileCard> createState() => _DrawerProfileCardState();
}

class _DrawerProfileCardState extends ConsumerState<DrawerProfileCard> {
  // String id = "";
  // String isLifeMember = "";
  // userDataLoad() async {
  //   final String lifeMember = await DbClient().getData(dbKey: "lifeMember");
  //   final String data = await DbClient().getData(dbKey: "userData");
  //   final LoginResponseModel loginResponseModel =
  //       LoginResponseModel.fromJson(data);
  //   // print(lifeMember);
  //   if (mounted)
  //     setState(() {
  //       id = loginResponseModel.id.toString();
  //       isLifeMember = lifeMember;
  //     });
  //   print(id);
  // }

  // loadMemberProfile() async {
  //   final String lifeMember = await DbClient().getData(dbKey: "lifeMember");
  //   setState(() {
  //     isLifeMember = lifeMember;
  //   });
  // }

  @override
  void initState() {
    // userDataLoad();
    ref.refresh(getmemberProfileControllerProvider);
    ref.refresh(userProfileControllerProvider);

    // loadMemberProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final isLifeMemberp = ref.watch(islifeMemberProviderProvider);
    final userProfile = ref.watch(userProfileControllerProvider);
    final memberProfile = ref.watch(getmemberProfileControllerProvider);
    //  final userProfile = ref.watch(userProfileControllerProvider);
    return widget.isLifeMember == "true"
        ?
        // Text("data")
        AsyncValueWidget(
            height: 60,
            value: memberProfile,
            data: (data) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColorResources.appSecondaryColor,
                  ),
                  // height: screenH * 0.19,
                  child: Column(children: [
                    ListTile(
                      // isThreeLine: true,
                      trailing: CachedNetworkImage(
                        // width: 50,
                        // height: 50,
                        imageUrl: AppImages.imageNetworkPath + data.photo,
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                              AppImages.imageNetworkPath + data.photo),
                          maxRadius: 25,
                        ),
                        placeholder: (context, url) => CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage(AppImages.userPlaceHolderNoInternet),
                          maxRadius: 25,
                        ),
                        errorWidget: (context, url, error) => CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage(AppImages.userPlaceHolderNoInternet),
                          maxRadius: 25,
                        ),
                      ),
                      // CircleAvatar(
                      //     maxRadius: 25,
                      //     backgroundColor: AppColorResources.white,
                      //     backgroundImage: NetworkImage(
                      //         AppImages.imageNetworkPath + data.photo)),
                      title: Text(
                        data.fname + " " + data.lname,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        data.email.toString(),
                        style: TextStyle(
                          fontFamily: "PS",
                          fontSize: 12,
                          color: CupertinoColors.white,
                        ),
                      ),
                    ),
                  ]),
                ),
            providerBase: getmemberProfileControllerProvider)
        : AsyncValueWidget(
            height: 60,
            providerBase: userProfileControllerProvider,
            value: userProfile,
            data: (data) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColorResources.appSecondaryColor),
              // height: screenH * 0.19,
              child: Column(children: [
                ListTile(
                  // isThreeLine: true,
                  trailing: CircleAvatar(
                      maxRadius: 25,
                      backgroundColor: AppColorResources.white,
                      onBackgroundImageError: (exception, stackTrace) {},
                      // child: Image.asset(AppImages.userPlaceHolderNoInternet),
                      backgroundImage:
                          // NetworkImage(AppImages.userPlaceHolderInternet),
                          data.photo == AppImages.userPlaceHolderInternet
                              ? NetworkImage(AppImages.userPlaceHolderInternet)
                              : NetworkImage(
                                  AppImages.imageNetworkPath + data.photo)),
                  title: Text(
                    data.fullName,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    data.email.toString(),
                    style: TextStyle(
                      fontFamily: "PS",
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ]),
            ),
          );
  }
}

// class DrawerProfileCard extends StatefulWidget {
//   const DrawerProfileCard({
//     super.key,
//   });

//   @override
//   State<DrawerProfileCard> createState() => _DrawerProfileCardState();
// }

// class _DrawerProfileCardState extends State<DrawerProfileCard> {
//   String name = "";
//   String email = "";
//   userDataLoad() async {
//     final String data = await DbClient().getData(dbKey: "userData");
//     final LoginResponseModel loginResponseModel =
//         LoginResponseModel.fromJson(data);
//     setState(() {
//       name = loginResponseModel.fullName;
//       email = loginResponseModel.email;
//     });
//   }

//   @override
//   void initState() {
//     userDataLoad();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: AppColorResources.appSecondaryColor,
//       ),
//       // height: screenH * 0.19,
//       child: Column(children: [
//         ListTile(
//           trailing: IconButton(
//               onPressed: () {}, icon: const Icon(FontAwesomeIcons.penToSquare)),
//           title: Text(
//             name,
//             style: const TextStyle(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//           subtitle: Text(
//             email,
//             style: TextStyle(color: Colors.black.withOpacity(0.5)),
//           ),
//         ),
//       ]),
//     );
//   }
// }

class DrawerItemWidget extends StatelessWidget {
  const DrawerItemWidget(
      {Key? key,
      required this.drawerLabel,
      required this.iconData,
      required this.onTap})
      : super(key: key);
  final String drawerLabel;
  final IconData iconData;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        horizontalTitleGap: 10,
        leading: Icon(
          iconData,
          color: const Color(0xff183153),
        ),
        title: Text(
          drawerLabel,
          style: const TextStyle(color: Colors.black),
        ),
        onTap: onTap);
  }
}
