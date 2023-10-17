// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';

class UpdateProfileRestModel {
  final String email;
  final String fullName;
  final String address;
  final String enrollment;
  final String userType;
  final String lifeMember;
  final MultipartFile? photo;
  UpdateProfileRestModel(
      {required this.email,
      required this.fullName,
      required this.address,
      required this.enrollment,
      required this.userType,
      required this.lifeMember,
      required this.photo});

  UpdateProfileRestModel copyWith(
      {String? email,
      String? fullName,
      String? address,
      String? enrollment,
      String? userType,
      String? lifeMember,
      MultipartFile? photo}) {
    return UpdateProfileRestModel(
        email: email ?? this.email,
        fullName: fullName ?? this.fullName,
        address: address ?? this.address,
        enrollment: enrollment ?? this.enrollment,
        userType: userType ?? this.userType,
        lifeMember: lifeMember ?? this.lifeMember,
        photo: photo ?? this.photo);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'full_name': fullName,
      'address': address,
      'enrollment': enrollment,
      'user_type': userType,
      'life_member': lifeMember,
      "photo": photo
    };
  }

  factory UpdateProfileRestModel.fromMap(Map<String, dynamic> map) {
    return UpdateProfileRestModel(
        email: map['email'] as String,
        fullName: map['full_name'] as String,
        address: map['address'] as String,
        enrollment: map['enrollment'] as String,
        userType: map['user_type'] as String,
        lifeMember: map['life_member'] as String,
        photo: map["photo"] as MultipartFile);
  }

  String toJson() => json.encode(toMap());

  factory UpdateProfileRestModel.fromJson(String source) =>
      UpdateProfileRestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UpdateProfileRestModel(email: $email, fullName: $fullName, address: $address, enrollment: $enrollment, userType: $userType, lifeMember: $lifeMember,photo:$photo)';
  }

  @override
  bool operator ==(covariant UpdateProfileRestModel other) {
    if (identical(this, other)) return true;

    return other.email == email &&
        other.fullName == fullName &&
        other.address == address &&
        other.enrollment == enrollment &&
        other.userType == userType &&
        other.photo == photo &&
        other.lifeMember == lifeMember;
  }

  @override
  int get hashCode {
    return email.hashCode ^
        fullName.hashCode ^
        address.hashCode ^
        enrollment.hashCode ^
        userType.hashCode ^
        photo.hashCode ^
        lifeMember.hashCode;
  }
}
