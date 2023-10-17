// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PradeshModel {
  final String id;
  final String pradesh_name;
  PradeshModel({
    required this.id,
    required this.pradesh_name,
  });

  PradeshModel copyWith({
    String? id,
    String? pradesh_name,
  }) {
    return PradeshModel(
      id: id ?? this.id,
      pradesh_name: pradesh_name ?? this.pradesh_name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'pradesh_name': pradesh_name,
    };
  }

  factory PradeshModel.fromMap(Map<String, dynamic> map) {
    return PradeshModel(
      id: map['id'] ?? "1",
      pradesh_name: map['pradesh_name'] ?? "-",
    );
  }

  String toJson() => json.encode(toMap());

  factory PradeshModel.fromJson(String source) =>
      PradeshModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'PradeshModel(id: $id, pradesh_name: $pradesh_name)';

  @override
  bool operator ==(covariant PradeshModel other) {
    if (identical(this, other)) return true;

    return other.id == id && other.pradesh_name == pradesh_name;
  }

  @override
  int get hashCode => id.hashCode ^ pradesh_name.hashCode;
}
