import 'dart:async';
import 'dart:io';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/features/conference/data/model/conferencesub_titlemodel.dart';
import 'package:nelta/features/conference/presentation/controllers/conferencesubheadingtitlelist_detail_controller.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/api_const/api_const.dart';

class ConferenceSubHeadingDetailScreen extends ConsumerWidget {
  const ConferenceSubHeadingDetailScreen(
      {super.key, required this.conferenceSubHeadingModel});
  final ConferenceSubHeadingModel conferenceSubHeadingModel;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // double screenH = MediaQuery.of(context).size.height;
    Future<bool> _handleLinkTap(String url) async {
      final data = Uri.parse(url);
      if (await canLaunchUrl(data)) {
        await launchUrl(data);
        return true;
      } else {
        return false;
      }
    }

    final conferenceList = ref.watch(confenceSubHeadingDetailProvider(
        conferenceSubHeadingModel.id.toString()));
    return Scaffold(
      appBar: AppBar(
        title: Text(conferenceSubHeadingModel.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // if (conferenceSubHeadingModel.conferenceFile.isNotEmpty)
              AsyncValueWidget(
                value: conferenceList,
                data: (data) {
                  String dataUrl =
                      ApiConst.openResource + data.conferenceDetailFile;
                  String removeB = dataUrl.replaceAll(RegExp(r'[\[\]"\\]'), '');
                  String removeQ = removeB.replaceAll('\\', '');
                  log(removeQ);
                  return Column(
                    children: [
                      // if (removeQ.isNotEmpty)
                      //   SizedBox(
                      //     height: screenH * 0.75,
                      //     child: SfPdfViewer.network(removeQ),
                      //   ),

                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: HtmlWidget(
                          data.content.replaceAll(RegExp(r'&nbsp;'), ''),
                          textStyle: GoogleFonts.poppins(),
                          onTapUrl: (url) => _handleLinkTap(url),
                        ),
                      ),
                      if (data.conferenceDetailFile.isNotEmpty)
                        ElevatedButton.icon(
                            onPressed: () {
                              String dataUrl = ApiConst.openResource +
                                  data.conferenceDetailFile;
                              String removeB =
                                  dataUrl.replaceAll(RegExp(r'[\[\]"\\]'), '');
                              String removeQ = removeB.replaceAll('\\', '');

                              openFile(context, url: removeQ);
                            },
                            icon: Icon(
                              Icons.file_download_outlined,
                            ),
                            label: Text("PDF")),
                    ],
                  );
                },
                // Text(
                //       data.content.replaceAll(RegExp(r'<[^>]*>'), ''),
                //     ),
                providerBase: confenceSubHeadingDetailProvider(
                    conferenceSubHeadingModel.id.toString()),
              )
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
      // log(e.toString());
      return null;
    }
  }
}
