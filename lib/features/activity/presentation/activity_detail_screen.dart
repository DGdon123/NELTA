import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nelta/features/activity/data/models/activity_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ActivityDetailScreen extends StatelessWidget {
  const ActivityDetailScreen({super.key, required this.e});
  final ActivityModel e;

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
        title: Text(e.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: HtmlWidget(
                  onTapUrl: (url) => _handleLinkTap(url),
                  e.content.replaceAll(RegExp(r'<[^>]*>|&nbsp;'), ''),
                  // e.content.replaceAll(RegExp(r'&nbsp;'), ''),
                  textStyle: GoogleFonts.poppins(),
                ),
              ),
              // Text(
              //   e.content.replaceAll(RegExp(r'<[^>]*>'), ''),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
