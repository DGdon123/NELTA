// ignore_for_file: public_member_api_docs, sort_constructors_first

class EventModel {
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
  EventModel({
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

  factory EventModel.fromMap(Map<String, dynamic> map) {
    return EventModel(
      id: map['id'] ?? 0,
      catId: map['cat_id'] ?? "",
      officeId: map['office_id'] ?? "",
      userId: map['user_id'] ?? "",
      eventTitle: map['event_title'] ?? "",
      articleType: map['article_type'] ?? "",
      eventStartDate: map['event_start_date'] ?? "",
      eventEndDate: map['event_end_date'] ?? "",
      eventTime: map['event_time'] ?? "",
      eventLocation: map['event_location'] ?? "",
      eventGoogleMap: map['event_google_map'] ?? "",
      eventDetails: map['event_details'] ?? "",
      eventPressCoverage: map['event_press_coverage'] ?? "",
      eventImage: map['event_image'] ?? "",
      eventActive: map['event_active'] ?? "",
    );
  }
}
