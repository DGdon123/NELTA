import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/app_const/app_images.dart';

class AboutDeveloperScreen extends StatelessWidget {
  const AboutDeveloperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.kappBarAboutDeveloper),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.appIymLogo,
                  height: 60,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const ListTile(
                    trailing: Icon(
                      FontAwesomeIcons.envelope,
                      color: AppColorResources.appBrowColor,
                    ),
                    title: Text(
                      AppConst.kymEmail,
                      style: TextStyle(fontSize: 14),
                    )),
                const ListTile(
                    trailing: Icon(
                      FontAwesomeIcons.globe,
                      color: AppColorResources.appBrowColor,
                    ),
                    title: Text(
                      AppConst.kymWeb,
                      style: TextStyle(fontSize: 14),
                    )),
                const ListTile(
                    trailing: Icon(
                      FontAwesomeIcons.phone,
                      color: AppColorResources.appBrowColor,
                    ),
                    title: Text(
                      AppConst.kymContact,
                      style: TextStyle(fontSize: 14),
                    )),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  AppImages.appIymAward,
                  height: 60,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
