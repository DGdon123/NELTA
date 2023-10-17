import 'dart:io';
import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/features/conference/data/model/conference_model.dart';
import 'package:nelta/features/conference/presentation/conference/conference_sub_heading.dart';
import 'package:nelta/features/conference/presentation/controllers/conferencesubheadingtitlelist_controller.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../common/shimmer widget/shimmer_widget.dart';
import '../../../../core/api_const/api_const.dart';

class ConferenceDetailScreen extends ConsumerWidget {
  const ConferenceDetailScreen({super.key, required this.conferenceModel});
  final ConferenceModel conferenceModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double screenH = MediaQuery.of(context).size.height;
    // double screenW = MediaQuery.of(context).size.width;
    // double screenH = MediaQuery.of(context).size.height;
    final conferenceList = ref.watch(
        conferencceSubHeadingListControllerProvider(
            conferenceModel.id.toString()));
    String dataUrl = ApiConst.openResource + conferenceModel.conferenceFile;
    String removeB = dataUrl.replaceAll(RegExp(r'[\[\]"\\]'), '');
    String removeQ = removeB.replaceAll('\\', '');
    Future<bool> _handleLinkTap(String url) async {
      final data = Uri.parse(url);
      if (await canLaunchUrl(data)) {
        await launchUrl(data);
        return true;
      } else {
        return false;
      }
    }

    String getSuffix(int day) {
      // Returns the suffix for a given day (e.g., "st" for 1, "nd" for 2, "rd" for 3, etc.)
      if (day >= 11 && day <= 13) {
        return 'th';
      }
      switch (day % 10) {
        case 1:
          return 'st';
        case 2:
          return 'nd';
        case 3:
          return 'rd';
        default:
          return 'th';
      }
    }

    String formatDate(String dateString) {
      // Parse the input date string into a DateTime object
      String paddedDateString = dateString.replaceAllMapped(
        RegExp(r'^(\d{4})-(\d{1,2})-(\d{1,2})$'),
        (match) =>
            '${match.group(1)}-${match.group(2)!.padLeft(2, '0')}-${match.group(3)!.padLeft(2, '0')}',
      );

      // Parse the input date string into a DateTime object
      DateTime date = DateTime.parse(paddedDateString);

      // Use the DateFormat class to format the date string in the desired format
      DateFormat formatter = DateFormat('d\'${getSuffix(date.day)}\' MMMM, y');
      return formatter.format(date);
    }

    String startD = formatDate(conferenceModel.startDate);
    String endD = formatDate(conferenceModel.endDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(conferenceModel.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Conference Details",
                style: TextStyle(
                    fontSize: 18,
                    color: AppColorResources.appBrowColor,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Color(0xffF2F2F2),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      conferenceModel.title,
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColorResources.appBrowColor,
                          fontWeight: FontWeight.bold),
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.globe,
                        color: Color(0xff183153),
                      ),
                      title: Text(
                        conferenceModel.venue,
                        maxLines: 2,
                      ),
                    ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.calendarDay,
                        color: Color(0xff183153),
                      ),
                      title: Text(
                        "From :" + "  " + startD,
                      ),
                    ),
                    if (conferenceModel.startTime.isNotEmpty)
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.clock,
                          color: Color(0xff183153),
                        ),
                        title: Text(
                          conferenceModel.startTime,
                        ),
                      ),
                    ListTile(
                      leading: Icon(
                        FontAwesomeIcons.calendarDay,
                        color: Color(0xff183153),
                      ),
                      title: Text(
                        "End :" + "  " + endD,
                      ),
                    ),
                    if (conferenceModel.endTime.isNotEmpty)
                      ListTile(
                        leading: Icon(
                          FontAwesomeIcons.clock,
                          color: Color(0xff183153),
                        ),
                        title: Text(
                          conferenceModel.endTime,
                        ),
                      ),
                    // SizedBox(
                    //   height: screenH * 0.75,
                    //   child: SfPdfViewer.network(removeQ),
                    // ),
                    if (conferenceModel.conferenceFile.isNotEmpty)
                      ElevatedButton.icon(
                          onPressed: () {
                            // String dataUrl = ApiConst.openResource +
                            //     conferenceModel.conferenceFile;
                            // String removeB =
                            //     dataUrl.replaceAll(RegExp(r'[\[\]"\\]'), '');
                            // String removeQ = removeB.replaceAll('\\', '');
                            // final name = removeQ.split("/").last;

                            openFile(context, url: removeQ);
                          },
                          icon: Icon(
                            Icons.file_download_outlined,
                          ),
                          label: Text("PDF"))
                  ],
                ),
              ),
              CachedNetworkImage(
                // width: screenW,
                // height: screenW,
                imageUrl:
                    ApiConst.openResource + conferenceModel.conferenceBanner,
                placeholder: (context, url) => ShimmerWidget(
                  listCount: 1,
                  listHeight: 100,
                  height: 100,
                ),
                errorWidget: (context, url, error) => Container(
                  // width: screenW * 0.26,
                  // height: screenH * 0.14,
                  decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: HtmlWidget(
                  conferenceModel.content,
                  textStyle: GoogleFonts.poppins(),
                  onTapUrl: (url) => _handleLinkTap(url),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              AsyncValueWidget(
                  isList: true,
                  listCount: 4,
                  value: conferenceList,
                  data: (data) => Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (data.isNotEmpty)
                            Text(
                              "Other Details",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: AppColorResources.appBrowColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ...data.map((e) => InkWell(
                                onTap: () {
                                  normalNav(
                                      context,
                                      ConferenceSubHeadingDetailScreen(
                                        conferenceSubHeadingModel: e,
                                      ));
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  alignment: Alignment.topLeft,
                                  width: MediaQuery.of(context).size.width,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  decoration: BoxDecoration(
                                      boxShadow: const [
                                        BoxShadow(
                                            color: AppColorResources.appBg,
                                            offset: Offset(6, 10),
                                            spreadRadius: -2)
                                      ],
                                      // border: BoxBorder(),
                                      color:
                                          AppColorResources.appSecondaryColor,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Text(
                                    e.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                        color: AppColorResources.white),
                                  ),
                                ),
                              ))
                        ],
                      ),
                  providerBase: conferencceSubHeadingListControllerProvider(
                      conferenceModel.id.toString()))
            ],
          ),
        ),
      ),
    );
  }

  // Future openFile({required String url, String? fileName}) async {
  //   final name = fileName ?? url.split("/").last;
  //   // log(name);
  //   final file = await downloadFile(url, name);
  //   if (file == null) return;
  //   print("paht${file.path}");
  //   OpenFile.open(file.path);
  // }

  // Future<File?> downloadFile(String url, String name) async {
  //   final appStorage = await getApplicationDocumentsDirectory();
  //   final file = File("/storage/emulated/0/Download/$name");
  //   log(file.toString() + "s");
  //   try {
  //     final response = await Dio().get(url,
  //         options: Options(
  //             responseType: ResponseType.bytes,
  //             followRedirects: false,
  //             receiveTimeout: Duration()));
  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //     return file;
  //   } catch (e) {
  //     return null;
  //   }
  // }
  Future openFile(BuildContext context,
      {required String url, String? fileName}) async {
    final name = fileName ?? url.split("/").last;
    final file = await downloadFile(context, url, name);

    if (file == null) return;
    print("paht${file.path}");
    await OpenFile.open(file.path);
  }

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

  // Future<void> downloadFile1(BuildContext context, String url) async {
  //   final name = url.split("/").last;
  //   final appPath = (await getApplicationDocumentsDirectory()).path;
  //   final filePath = '$appPath/${name}';
  //   final dio = Dio();
  //   try {
  //     await dio.download(url, filePath, onReceiveProgress: (received, total) {
  //       if (total != -1) {
  //         final progress = (received / total * 100).toStringAsFixed(0);
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text('$progress% downloaded'),
  //           ),
  //         );
  //       }
  //     });
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('File downloaded successfully'),
  //       ),
  //     );
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text('Failed to download file: $e'),
  //       ),
  //     );
  //   }
  // }
}
