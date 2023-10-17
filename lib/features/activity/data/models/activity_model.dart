class ActivityModel {
  ActivityModel({
    required this.id,
    required this.title,
    required this.content,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String title;
  String content;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory ActivityModel.fromJson(Map<String, dynamic> json) => ActivityModel(
        id: json["id"]??0,
        title: json["title"]??"",
        content: json["content"]??"",
        status: json["status"]??"",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
