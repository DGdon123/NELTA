import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/features/about_nelta/presentation/controller/aboutnelta_controller.dart';

import '../../../common/app_const/app_images.dart';

class AboutNeltaScreen extends ConsumerWidget {
  const AboutNeltaScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final double screenW = MediaQuery.of(context).size.width;
    final aboutNelta = ref.watch(aboutNeltaControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.kkappBarAbout),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Center(
                  child: Image.asset(
                    AppImages.appLogo,
                    height: screenW * 0.23,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              AsyncValueWidget(
                  isList: true,
                  listCount: 1,
                  value: aboutNelta,
                  data: (data) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HtmlWidget(
                          //     data.content.replaceAll(RegExp(r'&nbsp;'), ''),
                          //     textStyle:
                          //         Theme.of(context).textTheme.bodyMedium),
                          Text(
                            data.content.replaceAll(
                              RegExp(r'<[^>]*>|&#39'),
                              '',
                            ),
                            style: TextStyle(height: 2),
                          )
                        ],
                      ),
                  providerBase: aboutNeltaControllerProvider)
            ],
          ),
        ),
      ),
    );
  }
}
