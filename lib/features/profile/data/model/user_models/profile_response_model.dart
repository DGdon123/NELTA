// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProfileResponseModel {
  int id;
  String fullName;
  String address;
  String email;
  String password;
  String enrollment;
  String userType;
  String lifeMember;
  String status;
  String memberId;
  String registerDate;
  String countryId;
  String fcmToken;
  String photo;
  ProfileResponseModel(
      {required this.id,
      required this.fullName,
      required this.address,
      required this.email,
      required this.password,
      required this.enrollment,
      required this.userType,
      required this.lifeMember,
      required this.status,
      required this.memberId,
      required this.registerDate,
      required this.countryId,
      required this.fcmToken,
      required this.photo});

  ProfileResponseModel copyWith({
    int? id,
    String? fullName,
    String? address,
    String? email,
    String? password,
    String? enrollment,
    String? userType,
    String? lifeMember,
    String? status,
    String? memberId,
    String? registerDate,
    String? countryId,
    String? fcmToken,
    String? photo,
  }) {
    return ProfileResponseModel(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        address: address ?? this.address,
        email: email ?? this.email,
        password: password ?? this.password,
        enrollment: enrollment ?? this.enrollment,
        userType: userType ?? this.userType,
        lifeMember: lifeMember ?? this.lifeMember,
        status: status ?? this.status,
        memberId: memberId ?? this.memberId,
        registerDate: registerDate ?? this.registerDate,
        countryId: countryId ?? this.countryId,
        fcmToken: fcmToken ?? this.fcmToken,
        photo: photo ?? this.photo);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'full_name': fullName,
      'address': address,
      'email': email,
      'password': password,
      'enrollment': enrollment,
      'user_type': userType,
      'life_member': lifeMember,
      'status': status,
      'member_id': memberId,
      'register_date': registerDate,
      'country_id': countryId,
      'fcm_token': fcmToken,
      "photo": photo
    };
  }

  factory ProfileResponseModel.fromMap(Map<String, dynamic> map) {
    return ProfileResponseModel(
      id: map['id'] ?? 0,
      fullName: map['full_name'] ?? "",
      address: map['address'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      enrollment: map['enrollment'] ?? "",
      userType: map['user_type'] ?? "",
      lifeMember: map['life_member'] ?? "",
      status: map['status'] ?? "",
      memberId: map['member_id'] ?? "",
      registerDate: map['register_date'] ?? "",
      countryId: map['country_id'] ?? "",
      fcmToken: map['fcm_token'] ?? "",
      photo: map["photo"] ??
          "https://nelta.org.np/uploads/images/user_place_holder.png",
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileResponseModel.fromJson(String source) =>
      ProfileResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, fullName: $fullName, address: $address, email: $email, password: $password, enrollment: $enrollment, userType: $userType, lifeMember: $lifeMember, status: $status, memberId: $memberId, registerDate: $registerDate, countryId: $countryId, fcmToken: $fcmToken,photo:$photo)';
  }

  @override
  bool operator ==(covariant ProfileResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fullName == fullName &&
        other.address == address &&
        other.email == email &&
        other.password == password &&
        other.enrollment == enrollment &&
        other.userType == userType &&
        other.lifeMember == lifeMember &&
        other.status == status &&
        other.memberId == memberId &&
        other.registerDate == registerDate &&
        other.countryId == countryId &&
        other.photo == photo &&
        other.fcmToken == fcmToken;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fullName.hashCode ^
        address.hashCode ^
        email.hashCode ^
        password.hashCode ^
        enrollment.hashCode ^
        userType.hashCode ^
        lifeMember.hashCode ^
        status.hashCode ^
        memberId.hashCode ^
        registerDate.hashCode ^
        countryId.hashCode ^
        photo.hashCode ^
        fcmToken.hashCode;
  }
}
