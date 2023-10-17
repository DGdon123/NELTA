import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nelta/common/app_const/app_color.dart';
import 'package:nelta/features/notice/data/models/notice_model.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../core/api_const/api_const.dart';

class NoticeDetailScreen extends StatelessWidget {
  const NoticeDetailScreen({super.key, required this.e});
  final NoticesModel e;
  @override
  Widget build(BuildContext context) {
    Future<bool> _handleLinkTap(String url) async {
      final data = Uri.parse(url);
      if (await canLaunchUrl(data)) {
        await launchUrl(data);
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(e.noticeTitle),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: AppColorResources.appSecondaryColor),
                  child: Text(
                    e.noticeDate,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 10,
                        ),
                  )),
              Text(
                e.noticeTitle.replaceAll(
                  RegExp(r'<[^>]*>'),
                  '',
                ),
                style: TextStyle(
                    fontSize: 16,
                    color: AppColorResources.textRed,
                    fontWeight: FontWeight.bold),
              ),
              if (e.noticeImage.isNotEmpty)
                ElevatedButton.icon(
                    onPressed: () {
                      String dataUrl = ApiConst.openResource + e.noticeImage;
                      String removeB =
                          dataUrl.replaceAll(RegExp(r'[\[\]"\\]'), '');
                      String removeQ = removeB.replaceAll('\\', '');
                      // final name = removeQ.split("/").last;

                      openFile(context, url: removeQ);
                    },
                    icon: Icon(
                      Icons.file_download_outlined,
                    ),
                    label: Text("PDF")),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: HtmlWidget(
                  onTapUrl: (url) => _handleLinkTap(url),
                  e.noticeDetails.replaceAll(RegExp(r'&nbsp;'), ''),
                  textStyle: GoogleFonts.poppins(),
                ),
              ),
              // Text(
              //   e.noticeDetails.replaceAll(RegExp(r'<[^>]*>'), ''),
              // ),
            ],
          ),
        ),
      ),
    );
  }

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
}
