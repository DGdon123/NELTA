class AboutNeltaModel {
  AboutNeltaModel({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String content;
  DateTime createdAt;
  DateTime updatedAt;

  factory AboutNeltaModel.fromJson(Map<String, dynamic> json) =>
      AboutNeltaModel(
        id: json["id"]??0,
        content: json["content"]??"",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
