class ConferenceSubHeadinDetail {
  ConferenceSubHeadinDetail({
    required this.id,
    required this.conferenceId,
    required this.title,
    required this.content,
    required this.conferenceDetailFile,
  });

  int id;
  int conferenceId;
  String title;
  String content;
  String conferenceDetailFile;

  factory ConferenceSubHeadinDetail.fromJson(Map<String, dynamic> json) =>
      ConferenceSubHeadinDetail(
        id: json["id"] ?? 0,
        conferenceId: json["conference_id"] ?? 0,
        title: json["title"] ?? "",
        content: json["content"] ?? "",
        conferenceDetailFile: json["conference_detail_file"] ?? "",
      );
}
