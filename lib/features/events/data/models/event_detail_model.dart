class EventDetailModel {
  EventDetailModel({
    required this.id,
    required this.catId,
    required this.officeId,
    required this.userId,
    required this.eventTitle,
    required this.articleType,
    required this.eventStartDate,
    required this.eventEndDate,
    required this.eventTime,
    required this.eventLocation,
    required this.eventGoogleMap,
    required this.eventDetails,
    required this.eventPressCoverage,
    required this.eventImage,
    required this.eventActive,
  });

  int id;
  String catId;
  String officeId;
  String userId;
  String eventTitle;
  String articleType;
  String eventStartDate;
  String eventEndDate;
  String eventTime;
  String eventLocation;
  String eventGoogleMap;
  String eventDetails;
  String eventPressCoverage;
  String eventImage;
  String eventActive;

  factory EventDetailModel.fromJson(Map<String, dynamic> json) =>
      EventDetailModel(
        id: json["id"] ?? 0,
        catId: json["cat_id"] ?? "",
        officeId: json["office_id"] ?? "",
        userId: json["user_id"] ?? "",
        eventTitle: json["event_title"] ?? "",
        articleType: json["article_type"],
        eventStartDate: json["event_start_date"] ?? "",
        eventEndDate: json["event_end_date"] ?? "",
        eventTime: json["event_time"] ?? "",
        eventLocation: json["event_location"] ?? "",
        eventGoogleMap: json["event_google_map"] ?? "",
        eventDetails: json["event_details"] ?? "",
        eventPressCoverage: json["event_press_coverage"] ?? "",
        eventImage: json["event_image"] ?? "",
        eventActive: json["event_active"] ?? "",
      );
}
