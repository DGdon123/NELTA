import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/features/contact_us/presentation/controller/contact_us_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/api_const/api_const.dart';

class ContactUSScreen extends ConsumerWidget {
  const ContactUSScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenW = MediaQuery.of(context).size.width;
    final aboutNelta = ref.watch(contactUsControllerProvider);

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

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.kappBarContactUs),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              AsyncValueWidget(
                  isList: true,
                  listCount: 1,
                  value: aboutNelta,
                  data: (data) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 14),
                            margin: const EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColorResources.bgG),
                            width: screenW,
                            // height: 100,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data.officeName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          // fontSize: 10,
                                          color: AppColorResources.appBrowColor,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data.officeEmail,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    data.officeFax,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () async => await _launchFacebook(),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.facebook,
                                          color: Color(0xff1877F2),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(data.officeFbUrl)
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () async => openSocailMedia(
                                        socialUrl: ApiConst.youtubeURl),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          FontAwesomeIcons.youtube,
                                          color: Color(0xffFF0000),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                            child: Text(data.officeYoutubeUrl))
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        ],
                      ),
                  providerBase: contactUsControllerProvider)
            ],
          ),
        ),
      ),
    );
  }
}
