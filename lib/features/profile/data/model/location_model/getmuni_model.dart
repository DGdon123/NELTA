import 'dart:convert';

class MunicipalityModel {
  String id;
  String muniTypeId;
  String districtId;
  String muniCode;
  String muniName;
  String muniNameEn;
  MunicipalityModel({
    required this.id,
    required this.muniTypeId,
    required this.districtId,
    required this.muniCode,
    required this.muniName,
    required this.muniNameEn,
  });

  MunicipalityModel copyWith({
    String? id,
    String? muniTypeId,
    String? districtId,
    String? muniCode,
    String? muniName,
    String? muniNameEn,
  }) {
    return MunicipalityModel(
      id: id ?? this.id,
      muniTypeId: muniTypeId ?? this.muniTypeId,
      districtId: districtId ?? this.districtId,
      muniCode: muniCode ?? this.muniCode,
      muniName: muniName ?? this.muniName,
      muniNameEn: muniNameEn ?? this.muniNameEn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'muni_type_id': muniTypeId,
      'district_id': districtId,
      'muni_code': muniCode,
      'muni_name': muniName,
      'muni_name_en': muniNameEn,
    };
  }

  factory MunicipalityModel.fromMap(Map<String, dynamic> map) {
    return MunicipalityModel(
      id: map['id'] ?? "0",
      muniTypeId: map['muni_type_id'] ?? "0",
      districtId: map['district_id'] ?? "0",
      muniCode: map['muni_code'] ?? "0",
      muniName: map['muni_name'] ?? "-",
      muniNameEn: map['muni_name_en'] ?? "-",
    );
  }

  String toJson() => json.encode(toMap());

  factory MunicipalityModel.fromJson(String source) =>
      MunicipalityModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MunicipalityModel(id: $id, muniTypeId: $muniTypeId, districtId: $districtId, muniCode: $muniCode, muniName: $muniName, muniNameEn: $muniNameEn)';
  }

  @override
  bool operator ==(covariant MunicipalityModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.muniTypeId == muniTypeId &&
        other.districtId == districtId &&
        other.muniCode == muniCode &&
        other.muniName == muniName &&
        other.muniNameEn == muniNameEn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        muniTypeId.hashCode ^
        districtId.hashCode ^
        muniCode.hashCode ^
        muniName.hashCode ^
        muniNameEn.hashCode;
  }
}
