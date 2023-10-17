class ConferenceSubHeadingModel {
  ConferenceSubHeadingModel({
    required this.id,
    required this.conferenceId,
    required this.title,
    required this.conferenceFile,
  });

  int id;
  String conferenceId;
  String title;
  String conferenceFile;
  factory ConferenceSubHeadingModel.fromJson(Map<String, dynamic> json) =>
      ConferenceSubHeadingModel(
          id: json["id"],
          conferenceId: json["conference_id"],
          title: json["title"],
          conferenceFile: json["conference_detail_file"] ?? "");
}
