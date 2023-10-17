import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/app_const/app_const.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/features/conference/presentation/conference/conference_detail_screen.dart';
import 'package:nelta/features/conference/presentation/controllers/conferencelist_controller.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';

class ComferenceScreen extends ConsumerWidget {
  const ComferenceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conferenceList = ref.watch(conferenceListControllerProvider);
    double screenW = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: const Text(AppConst.kappBarConference),
        ),
        body: AsyncValueWidget(
            isList: true,
            listCount: 4,
            value: conferenceList,
            data: (data) => SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: [
                        ...data.map(
                          (e) => InkWell(
                            onTap: () => normalNav(
                                context,
                                ConferenceDetailScreen(
                                  conferenceModel: e,
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
                                          e.startDate,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                        )),
                                    Text(
                                      e.venue,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13,
                                            color:
                                                AppColorResources.appBrowColor,
                                          ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(e.title),
                                  ]),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ).animate().fadeIn().flipV(duration: Duration(seconds: 1)),
            providerBase: conferenceListControllerProvider));
  }
}
