// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class District {
  String id;
  String pradeshId;
  String districtCode;
  String nepaliName;
  String englishName;

  District({
    required this.id,
    required this.pradeshId,
    required this.districtCode,
    required this.nepaliName,
    required this.englishName,
  });

  District copyWith({
    String? id,
    String? pradeshId,
    String? districtCode,
    String? nepaliName,
    String? englishName,
  }) {
    return District(
      id: id ?? this.id,
      pradeshId: pradeshId ?? this.pradeshId,
      districtCode: districtCode ?? this.districtCode,
      nepaliName: nepaliName ?? this.nepaliName,
      englishName: englishName ?? this.englishName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pradesh_id': pradeshId,
      'district_code': districtCode,
      'nepali_name': nepaliName,
      'english_name': englishName,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      id: map['id'] ??"1",
      pradeshId: map['pradesh_id'] ??"1",
      districtCode: map['district_code'] ??"",
      nepaliName: map['nepali_name'] ??"-",
      englishName: map['english_name'] ??"-",
    );
  }

  String toJson() => json.encode(toMap());

  factory District.fromJson(String source) =>
      District.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'District(id: $id, pradeshId: $pradeshId, districtCode: $districtCode, nepaliName: $nepaliName, englishName: $englishName)';
  }

  @override
  bool operator ==(covariant District other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.pradeshId == pradeshId &&
        other.districtCode == districtCode &&
        other.nepaliName == nepaliName &&
        other.englishName == englishName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        pradeshId.hashCode ^
        districtCode.hashCode ^
        nepaliName.hashCode ^
        englishName.hashCode;
  }
}
