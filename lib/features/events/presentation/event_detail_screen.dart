import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nelta/common/asyn_widget/asyncvalue_widget.dart';
import 'package:nelta/features/events/data/models/eventlist_model.dart';
import 'package:nelta/features/events/presentation/controller/eventdetail_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:photo_view/photo_view.dart';
import '../../../common/app_const/app_color.dart';
import '../../../common/shimmer widget/shimmer_widget.dart';
import '../../../core/api_const/api_const.dart';

class EventDetailScreen extends ConsumerWidget {
  const EventDetailScreen({super.key, required this.e});
  final EventModel e;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      DateTime date = DateTime.parse(dateString);

      // Use the DateFormat class to format the date string in the desired format
      DateFormat formatter = DateFormat('d\'${getSuffix(date.day)}\' MMMM, y');
      return formatter.format(date);
    }

    final eventDetail =
        ref.watch(eventDetailControllerProvider(e.id.toString()));
    return Scaffold(
      appBar: AppBar(
        title: Text(e.eventTitle),
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
                    String eventSD = formatDate(data.eventStartDate);
                    String eventED = formatDate(data.eventEndDate);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (data.eventImage.isNotEmpty)
                          SizedBox(
                            height: 10,
                          ),
                        Text(
                          "Event Details",
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColorResources.appBrowColor,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 14),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Color(0xffF2F2F2),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                data.eventTitle,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: AppColorResources.appBrowColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              if (data.eventLocation.isNotEmpty)
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.globe,
                                    color: Color(0xff183153),
                                  ),
                                  title: Text(
                                    data.eventLocation,
                                    maxLines: 2,
                                  ),
                                ),
                              if (data.eventStartDate.isNotEmpty)
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.calendarDay,
                                    color: Color(0xff183153),
                                  ),
                                  title: Text(
                                    "From :" + "  " + eventSD,
                                  ),
                                ),
                              if (data.eventEndDate.isNotEmpty)
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.calendarDay,
                                    color: Color(0xff183153),
                                  ),
                                  title: Text(
                                    "To :" + "  " + eventED,
                                  ),
                                ),
                              if (data.eventTime.isNotEmpty)
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.clock,
                                    color: Color(0xff183153),
                                  ),
                                  title: Text(
                                    data.eventTime,
                                  ),
                                ),
                              if (data.articleType.isNotEmpty)
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.book,
                                    color: Color(0xff183153),
                                  ),
                                  title: Text(
                                    "Type :" + "  " + data.articleType,
                                  ),
                                ),

                              // SizedBox(
                              //   height: screenH * 0.75,
                              //   child: SfPdfViewer.network(removeQ),
                              // ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ImageScreen(
                                    imageURL: ApiConst.openResource +
                                        data.eventImage),
                              ),
                            );
                          },
                          child: CachedNetworkImage(
                            // width: screenW,
                            // height: screenW,
                            imageUrl: ApiConst.openResource + data.eventImage,
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
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: HtmlWidget(
                            onTapUrl: (url) => _handleLinkTap(url),
                            data.eventDetails.replaceAll(RegExp(r'&nbsp;'), ''),
                            textStyle: GoogleFonts.poppins(),
                          ),
                        ),
                      ],
                    );
                  },
                  providerBase: eventDetailControllerProvider(e.id.toString()))
            ],
          ),
        ),
      ),
    );
  }
}

class ImageScreen extends StatelessWidget {
  final String imageURL;

  const ImageScreen({
    Key? key,
    required this.imageURL,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(
          imageProvider: NetworkImage(imageURL),
          minScale: PhotoViewComputedScale.contained,
          maxScale: PhotoViewComputedScale.covered * 2,
          backgroundDecoration: BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColorResources.white,
          child: Icon(
            Icons.arrow_back_rounded,
            size: 30,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
    );
  }
}
