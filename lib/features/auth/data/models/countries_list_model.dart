class CountryModel {
  int id;
  String countryName;
  String shortName;
  String status;
  CountryModel({
    required this.id,
    required this.countryName,
    required this.shortName,
    required this.status,
  });
  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        id: json["id"],
        countryName: json["country_name"],
        shortName: json["short_name"],
        status: json["status"],
      );
}
