import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/mou_partner/presentation/controller/mou_controller.dart';

class MouPartnerScreen extends ConsumerWidget {
  const MouPartnerScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenW = MediaQuery.of(context).size.width;
    double screenH = MediaQuery.of(context).size.height;
    final aboutNelta = ref.watch(mouPartnerControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConst.kappBarMouPartner),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              AsyncValueWidget(
                  isList: true,
                  listCount: 4,
                  value: aboutNelta,
                  data: (data) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...data.map(
                            (e) => InkWell(
                              child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      CachedNetworkImage(
                                        width: 80,
                                        height: 80,
                                        imageUrl:
                                            ApiConst.openResource + e.logo,
                                        placeholder: (context, url) =>
                                            Container(
                                          width: screenW * 0.26,
                                          height: screenH * 0.14,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                          width: screenW * 0.26,
                                          height: screenH * 0.14,
                                          decoration: BoxDecoration(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              borderRadius:
                                                  BorderRadius.circular(20)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        e.name,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                              fontWeight: FontWeight.bold,
                                              // fontSize: 10,
                                              color: AppColorResources
                                                  .appBrowColor,
                                            ),
                                      ),
                                      // Text(
                                      //   e.noticeDetails
                                      //       .replaceAll(RegExp(r'<[^>]*>'), ''),
                                      //   style: Theme.of(context)
                                      //       .textTheme
                                      //       .bodySmall!
                                      //       .copyWith(
                                      //         fontWeight: FontWeight.normal,
                                      //         fontSize: 10,
                                      //         color: AppColorResources
                                      //             .TEXT_GRAY_COLOR,
                                      //       ),
                                      //   maxLines: 1,
                                      // ),
                                    ]),
                              ),
                            ),
                          )
                        ],
                      ),
                  providerBase: mouPartnerControllerProvider)
            ],
          ),
        ),
      ),
    );
  }
}
