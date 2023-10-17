import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nelta/features/conference/data/model/branch_model.dart';

class BranchDetailScreen extends StatelessWidget {
  const BranchDetailScreen({super.key, required this.e});
  final BranchModel e;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(e.officeName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            children: [
              // Text(
              //   e.aboutOffice.replaceAll(RegExp(r'<[^>]*>'), ''),
              // ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: HtmlWidget(
                  e.aboutOffice.replaceAll(RegExp(r'&nbsp;'), ''),
                  textStyle: GoogleFonts.poppins(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
