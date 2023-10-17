class ConferenceModel {
  ConferenceModel({
    required this.id,
    required this.title,
    required this.venue,
    required this.order,
    required this.latitude,
    required this.longitude,
    required this.content,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.status,
    required this.highlight,
    required this.conferenceFile,
    required this.conferenceBanner,
    required this.userId,
  });

  int id;
  String title;
  String venue;
  String order;
  String latitude;
  String longitude;
  String content;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  String status;
  String highlight;
  String conferenceFile;
  String conferenceBanner;
  String userId;

  factory ConferenceModel.fromJson(Map<String, dynamic> json) =>
      ConferenceModel(
        id: json["id"],
        title: json["title"] ?? "",
        venue: json["venue"] ?? "",
        order: json["order"] ?? "",
        latitude: json["latitude"] ?? "",
        longitude: json["longitude"] ?? "",
        content: json["content"] ?? "",
        startDate: json["start_date"] ?? "",
        startTime: json["start_time"] ?? "",
        endDate: json["end_date"] ?? "",
        endTime: json["end_time"] ?? "",
        status: json["status"] ?? "",
        highlight: json["highlight"] ?? "",
        conferenceFile: json["conference_file"] ?? "",
        conferenceBanner: json["conference_banner"] ?? "",
        userId: json["user_id"] ?? 0,
      );
}
