import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import '../controllers/resources_list_controller.dart';
import 'resources_detail_screen.dart';

class ResourcesListScreen extends ConsumerWidget {
  const ResourcesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resourceList = ref.watch(resouresListController);
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppConst.kappBarResources),
        ),
        body: AsyncValueWidget(
            isList: true,
            listCount: 4,
            value: resourceList,
            data: (data) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        ...data.map(
                          (e) => InkWell(
                            onTap: () => normalNav(
                                context,
                                ResourcesDetailScreen(
                                  e: e,
                                )),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: AppColorResources
                                                .appSecondaryColor),
                                        child: Text(
                                          e.date,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!
                                              .copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                        )),
                                    Text(
                                      e.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            // fontSize: 10,
                                            color:
                                                AppColorResources.appBrowColor,
                                          ),
                                    ),
                                    Text(
                                      e.content
                                          .replaceAll(RegExp(r'<[^>]*>'), ''),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 10,
                                            color: AppColorResources.textGrey,
                                          ),
                                      maxLines: 1,
                                    ),
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
            providerBase: resouresListController));
  }
}
