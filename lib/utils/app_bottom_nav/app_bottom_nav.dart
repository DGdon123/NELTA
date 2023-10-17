import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:url_launcher/url_launcher.dart';

class AppButtomNavigation extends StatefulWidget {
  const AppButtomNavigation({
    super.key,
  });

  @override
  State<AppButtomNavigation> createState() => _AppButtomNavigationState();
}

class _AppButtomNavigationState extends State<AppButtomNavigation>
    with TickerProviderStateMixin {
  openWebsite() async {
    final neltaWebURl = Uri.parse(ApiConst.websiteUrl);

    if (await canLaunchUrl(neltaWebURl)) {
      await launchUrl(neltaWebURl, mode: LaunchMode.inAppWebView);
    }
  }

  openDial() async {
    const phoneUrl = ApiConst.contactNumber;
    final url = Uri.parse('tel:$phoneUrl');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  late AnimationController controller;
  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 1000);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  openSocailMedia({required String socialUrl}) async {
    final neltaWebURl = Uri.parse(socialUrl);

    if (await canLaunchUrl(neltaWebURl)) {
      await launchUrl(neltaWebURl, mode: LaunchMode.inAppWebView);
    }
  }

  _launchFacebook() async {
    const url = 'https://www.facebook.com/neltanpl/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(color: Colors.white),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () async => await openWebsite(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(FontAwesomeIcons.globe),
                ),
                Text(AppConst.kweb)
              ],
            ),
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  transitionAnimationController: controller,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(25.0),
                    ),
                  ),
                  builder: (context) {
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.35,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.only(right: 20, top: 10),
                                  child: IconButton(
                                    icon: Icon(FontAwesomeIcons.xmark),
                                    onPressed: () => Navigator.pop(context),
                                    // FontAwesomeIcons.xmark,
                                    // color: Colors.black,
                                  ),
                                )),
                            Text(
                              "Visit Us",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xff1877F2)),
                                onPressed: () async => await _launchFacebook(),
                                icon: const Icon(FontAwesomeIcons.facebook),
                                label: const Text(AppConst.kfaceBook)),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffFF0000)),
                                onPressed: () async => openSocailMedia(
                                    socialUrl: ApiConst.youtubeURl),
                                icon: const Icon(FontAwesomeIcons.youtube),
                                label: const Text(AppConst.kyouTube))
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(FontAwesomeIcons.shareNodes),
                ),
                Text("Info")
              ],
            ),
          ),
          InkWell(
            onTap: () async => await openDial(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Icon(FontAwesomeIcons.addressCard),
                ),
                Text("Contact")
              ],
            ),
          )
        ],
      ),
    );
    // BottomNavigationBar(
    //     // showSelectedLabels: false,
    //     // showUnselectedLabels: false,
    //     type: BottomNavigationBarType.fixed,
    //     unselectedItemColor: Colors.white,
    //     selectedItemColor: Colors.white,
    //     backgroundColor: AppColorResources.appSecondaryColor,
    //     items: <BottomNavigationBarItem>[
    //       BottomNavigationBarItem(
    //         icon: InkWell(
    //             onTap: () async => openWebsite(),
    //             child: const Icon(FontAwesomeIcons.globe)),
    //         label: 'Web',
    //       ),
    //       // BottomNavigationBarItem(
    //       //   icon: Icon(FontAwesomeIcons.squareFacebook),
    //       //   label: 'Home',
    //       // ),
    //       const BottomNavigationBarItem(
    //         icon: SocialMediaModularSheet(),
    //         label: 'Info',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: InkWell(
    //             onTap: () async => openDial(),
    //             child: const Icon(FontAwesomeIcons.addressCard)),
    //         label: 'Contact',
    //       ),
    //     ]);
  }
}

class SocialMediaModularSheet extends StatefulWidget {
  const SocialMediaModularSheet({
    super.key,
  });

  @override
  State<SocialMediaModularSheet> createState() =>
      _SocialMediaModularSheetState();
}

class _SocialMediaModularSheetState extends State<SocialMediaModularSheet>
    with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  initState() {
    super.initState();
    controller = BottomSheet.createAnimationController(this);
    controller.duration = const Duration(milliseconds: 1000);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  openSocailMedia({required String socialUrl}) async {
    final neltaWebURl = Uri.parse(socialUrl);

    if (await canLaunchUrl(neltaWebURl)) {
      await launchUrl(neltaWebURl, mode: LaunchMode.inAppWebView);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          await showModalBottomSheet(
              transitionAnimationController: controller,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (context) {
                return SizedBox(
                  height: 200,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, top: 20),
                              child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.xmark,
                                    color: Colors.black,
                                  )),
                            )),
                        Text(
                          "Visit Us",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff1877F2)),
                            onPressed: () async => openSocailMedia(
                                socialUrl: ApiConst.facebookURL),
                            icon: const Icon(FontAwesomeIcons.facebook),
                            label: const Text(AppConst.kfaceBook)),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xffFF0000)),
                            onPressed: () async =>
                                openSocailMedia(socialUrl: ApiConst.youtubeURl),
                            icon: const Icon(FontAwesomeIcons.youtube),
                            label: const Text(AppConst.kyouTube))
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(FontAwesomeIcons.shareNodes));
  }
}
