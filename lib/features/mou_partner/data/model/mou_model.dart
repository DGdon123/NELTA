class MouPartnerModel {
  MouPartnerModel({
    required this.id,
    required this.name,
    required this.websiteUrl,
    required this.logo,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String websiteUrl;
  String logo;
  DateTime createdAt;
  DateTime updatedAt;

  factory MouPartnerModel.fromJson(Map<String, dynamic> json) =>
      MouPartnerModel(
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        websiteUrl: json["website_url"] ?? "",
        logo: json["logo"] ?? "",
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}
