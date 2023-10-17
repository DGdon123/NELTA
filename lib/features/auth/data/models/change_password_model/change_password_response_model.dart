// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChangePasswordResponseModel {
  final String success;

  ChangePasswordResponseModel({required this.success});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
    };
  }

  factory ChangePasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return ChangePasswordResponseModel(
      success: map['success'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory ChangePasswordResponseModel.fromJson(String source) =>
      ChangePasswordResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
