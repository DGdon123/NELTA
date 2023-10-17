// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SignUpRequestModel {
  final String email;
  final String password;
  final String fullName;
  final String address;
  final String enrollment;
  final String userType;
  final String lifeMember;
  final int countryId;
  final String? member_id;
  final String fcmToken;
  SignUpRequestModel(
      {required this.countryId,
      required this.fcmToken,
      required this.password,
      required this.email,
      required this.fullName,
      required this.address,
      required this.enrollment,
      required this.userType,
      required this.lifeMember,
      this.member_id});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      'full_name': fullName,
      'address': address,
      'enrollment': enrollment,
      'user_type': userType,
      'life_member': lifeMember,
      'country_id': countryId,
      'fcm_token': fcmToken,
      "member_id": member_id,
    };
  }

  factory SignUpRequestModel.fromMap(Map<String, dynamic> map) {
    return SignUpRequestModel(
      email: map['email'] as String,
      password: map['password'] as String,
      fullName: map['fullName'] as String,
      address: map['address'] as String,
      enrollment: map['enrollment'] as String,
      userType: map['userType'] as String,
      lifeMember: map['lifeMember'] as String,
      countryId: map['countryId'] as int,
      member_id: map['member_id'] as String,
      fcmToken: map['fcmToken'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SignUpRequestModel.fromJson(String source) =>
      SignUpRequestModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
