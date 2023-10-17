import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_images.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import 'package:permission_handler/permission_handler.dart';
import 'common/app_const/app_const.dart';
import 'core/api_const/db_client.dart';
import 'features/activity/presentation/activity_screen.dart';
import 'features/branch/branch_screen.dart';
import 'features/conference/presentation/conference/conference_screen.dart';
import 'features/events/presentation/event_screen.dart';
import 'features/home/presentation/widgets/home_option_card.dart';
import 'features/notice/presentation/notices_screen.dart';
import 'features/resources/presentation/views/resouces_list_screen.dart';
import 'utils/app drawer/app_drawer.dart';
import 'utils/app_bottom_nav/app_bottom_nav.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({super.key});

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  void getPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
    ].request();
  }

  String isLifeMember = "";
  bool showAlertDialog = true;

  userDataLoad() async {
    final String lifeMember = await DbClient().getData(dbKey: "lifeMember");

    if (mounted) {
      if (showAlertDialog) {
        if (mounted)
          setState(() {
            showAlertDialog = false;
          });

        await _showDialog();
      }
    }
  }

  Future<void> _showDialog() async {
    // await Future.delayed(Duration(seconds: 2));
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(
            'Welcome to NELTA',
            style: TextStyle(fontFamily: "PS", fontWeight: FontWeight.bold),
          ),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                AppImages.appLogo,
                fit: BoxFit.cover,
                height: 120,
              ),
            ).animate().flipV(duration: Duration(seconds: 1)),
          )
          // Container(
          //   margin: EdgeInsets.symmetric(vertical: 10),
          //   height: MediaQuery.of(context).size.height * 0.2,
          //   decoration: BoxDecoration(
          //       color: Colors.red,
          //       borderRadius: BorderRadius.circular(10),
          //       image: DecorationImage(
          //         fit: BoxFit.cover,
          //         image: AssetImage(AppImages.appLogo),
          //       )),
          // ),
          // actions: <Widget>[
          //   CupertinoDialogAction(
          //     child: Text('Cancel'),
          //     onPressed: () => Navigator.of(context).pop(),
          //   ),
          // ],
          ),
    );
    await Future.delayed(Duration(seconds: 3));
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    getPermission();
    userDataLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ref.read(getmemberProfileControllerProvider);
    // ref.read(userProfileControllerProvider);
    // ref.read(districtController);
    final double screenW = MediaQuery.of(context).size.width;
    final double screenH = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: const AppButtomNavigation(),
      backgroundColor: const Color(0xffF2F2F2),
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text(AppConst.kappBarDashboard),
        actions: [
          IconButton(
              onPressed: () {
                normalNav(context, const NoticeListScreen());
              },
              icon: const Icon(FontAwesomeIcons.bell))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    color: AppColorResources.appPrimaryColor,
                  ),
                  width: screenW,
                  height: screenH * 0.14,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10, left: 6, right: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color(0xffF2F2F2),
                  ),
                  width: screenW,
                  // height: screenH,
                  child: Column(
                    children: [
                      // SizedBox(
                      //     height: screenH * 0.64, child: const HomeOption()),
                      SizedBox(
                          height: screenH * 0.79,
                          child: GridView.count(
                            shrinkWrap: true,
                            primary: false,
                            padding: const EdgeInsets.all(15),
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            crossAxisCount: 2,
                            children: <Widget>[
                              HomeOptionCard(
                                onTap: () {
                                  // log("x");
                                  normalNav(context, const ComferenceScreen());
                                },
                                option: AppConst.kappBarConference,
                                optionLogo: AppImages.appIConference,
                              ),
                              HomeOptionCard(
                                onTap: () => normalNav(
                                    context, const ResourcesListScreen()),
                                option: AppConst.kappBarResources,
                                optionLogo: AppImages.appIResources,
                              ),
                              HomeOptionCard(
                                onTap: () {
                                  normalNav(context, const EventListScreen());
                                },
                                option: AppConst.kappBarEvents,
                                optionLogo: AppImages.appIEvent,
                              ),
                              HomeOptionCard(
                                onTap: () {
                                  normalNav(context, const NoticeListScreen());
                                },
                                option: AppConst.kappBarNotice,
                                optionLogo: AppImages.appINotice,
                              ),
                              HomeOptionCard(
                                onTap: () {
                                  normalNav(
                                      context, const ActivityListScreen());
                                },
                                option: AppConst.kappBarActivitie,
                                optionLogo: AppImages.appIActivity,
                              ),
                              HomeOptionCard(
                                onTap: () => normalNav(
                                    context, const BranchListScreen()),
                                option: AppConst.kappBarbranches,
                                optionLogo: AppImages.appIBranch,
                              ),
                            ],
                          )
                              .animate()
                              .slideX(duration: Duration(seconds: 1))
                              .fadeIn()),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeOption extends ConsumerWidget {
  const HomeOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      childAspectRatio: 3.5 / 2,
      children: [
        HomeOptionCard2(
          onTap: () {
            normalNav(context, const ComferenceScreen());
          },
          option: AppConst.kappBarConference,
          optionLogo: AppImages.appIConference,
        ),
        HomeOptionCard2(
          onTap: () => normalNav(context, const ResourcesListScreen()),
          option: AppConst.kappBarResources,
          optionLogo: AppImages.appIResources,
        ),
        HomeOptionCard2(
          onTap: () {
            normalNav(context, const EventListScreen());
          },
          option: AppConst.kappBarEvents,
          optionLogo: AppImages.appIEvent,
        ),
        HomeOptionCard2(
          onTap: () {
            normalNav(context, const NoticeListScreen());
          },
          option: AppConst.kappBarNotice,
          optionLogo: AppImages.appINotice,
        ),
        HomeOptionCard2(
          onTap: () {
            normalNav(context, const ActivityListScreen());
          },
          option: AppConst.kappBarActivitie,
          optionLogo: AppImages.appIActivity,
        ),
        HomeOptionCard2(
          onTap: () => normalNav(context, const BranchListScreen()),
          option: AppConst.kappBarbranches,
          optionLogo: AppImages.appIBranch,
        ),
      ],
    );
  }
}
