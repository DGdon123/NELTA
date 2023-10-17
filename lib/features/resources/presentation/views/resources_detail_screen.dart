import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/api_const/api_const.dart';
import '../../data/model/resources_model.dart';
import '../controllers/resources_detail_controller.dart';

class ResourcesDetailScreen extends ConsumerWidget {
  const ResourcesDetailScreen({super.key, required this.e});
  final ResoucesModel e;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenW = MediaQuery.of(context).size.width;
    // double screenH = MediaQuery.of(context).size.height;
    final eventDetail =
        ref.watch(resourcesDetailControllerProvider(e.id.toString()));

    Future<File?> downloadFile(
        BuildContext context, String url, String name) async {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File("${appStorage.path}/$name");
      try {
        final response = await Dio().get(url,
            //     onReceiveProgress: (received, total) {
            //   if (total != -1) {
            //     final progress = (received / total * 100).toStringAsFixed(0);
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       SnackBar(
            //         content: Text('$progress% downloaded'),
            //       ),
            //     );
            //   }
            // },
            options: Options(
                responseType: ResponseType.bytes,
                followRedirects: false,
                receiveTimeout: Duration(seconds: 10)));
        final raf = file.openSync(mode: FileMode.write);
        raf.writeFromSync(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('File downloaded successfully'),
          ),
        );
        await raf.close();

        return file;
      } catch (e) {
        log(e.toString());
        return null;
      }
    }

    Future openFile(BuildContext context,
        {required String url, String? fileName}) async {
      final name = fileName ?? url.split("/").last;
      final file = await downloadFile(context, url, name);

      if (file == null) return;
      print("paht${file.path}");
      await OpenFile.open(file.path);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(e.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            children: [
              AsyncValueWidget(
                  isList: true,
                  listCount: 4,
                  value: eventDetail,
                  data: (data) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 14),
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffF2F2F2),
                      ),
                      width: screenW,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
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
                                Container(
                                    margin: const EdgeInsets.only(bottom: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 2),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColorResources.appBrowColor),
                                    child: Text(
                                      e.type,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 10,
                                          ),
                                    )),
                              ],
                            ),
                            Text(
                              e.title,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    // fontSize: 10,
                                    color: AppColorResources.appBrowColor,
                                  ),
                            ),
                            Text(
                              e.content.replaceAll(RegExp(r'<[^>]*>'), ''),
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
                            if (e.file.isNotEmpty)
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "File",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          fontWeight: FontWeight.bold,
                                          // fontSize: 10,
                                          color: AppColorResources.appBrowColor,
                                        ),
                                  ),

                                  // SizedBox(
                                  //   height: screenH * 0.75,
                                  //   child: SfPdfViewer.network(
                                  //       ApiConst.openResource + data[1].file),
                                  // ),
                                ],
                              ),
                            ...data.map(
                              (e) {
                                String dataUrl =
                                    ApiConst.openResource + e.downloadFile;
                                String removeB = dataUrl.replaceAll(
                                    RegExp(r'[\[\]"\\]'), '');
                                String removeQ = removeB.replaceAll('\\', '');

                                return e.downloadFile.isNotEmpty
                                    ? InkWell(
                                        onTap: () async => await openFile(
                                            context,
                                            url: removeQ),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          padding: EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 10),
                                          alignment: Alignment.topLeft,
                                          width: screenW,
                                          // height: screenH * 0.1,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Column(
                                            children: [
                                              ListTile(
                                                // isThreeLine: true,
                                                // dense: true,
                                                contentPadding: EdgeInsets.zero,
                                                leading: IconButton(
                                                    onPressed: () async {
                                                      await openFile(context,
                                                          url: removeQ);
                                                    },
                                                    icon: Icon(
                                                      FontAwesomeIcons
                                                          .fileCircleCheck,
                                                      color: Color(0xff183153),
                                                    )),
                                                subtitle: Text(
                                                  e.downloadDetails,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 10,
                                                        color: AppColorResources
                                                            .textGrey,
                                                      ),
                                                ),
                                                title: Text(
                                                  e.downloadTitle,
                                                  textAlign: TextAlign.left,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall!
                                                      .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 13,
                                                        color: AppColorResources
                                                            .TEXT_BLACK_COLOR,
                                                      ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 10),
                                        alignment: Alignment.topLeft,
                                        width: screenW,
                                        // height: screenH * 0.1,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: ListTile(
                                          // isThreeLine: true,
                                          // dense: true,
                                          contentPadding: EdgeInsets.zero,
                                          // leading: IconButton(
                                          //     onPressed: () {},
                                          //     icon: Icon(
                                          //       FontAwesomeIcons.filePdf,
                                          //       color: Color(0xff183153),
                                          //     )),
                                          subtitle: Text(
                                            e.downloadDetails,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 10,
                                                  color: AppColorResources
                                                      .textGrey,
                                                ),
                                          ),
                                          title: Text(
                                            e.downloadTitle,
                                            textAlign: TextAlign.left,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13,
                                                  color: AppColorResources
                                                      .TEXT_BLACK_COLOR,
                                                ),
                                          ),
                                        ),
                                      );
                              },
                            ),
                          ]),
                    );
                  },
                  providerBase:
                      resourcesDetailControllerProvider(e.id.toString()))
            ],
          ),
        ),
      ),
    );
  }
}
