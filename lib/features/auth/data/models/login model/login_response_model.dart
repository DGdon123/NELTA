// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class LoginResponseModel {
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
  // int province_id;
  // int district_id;
  // int muni_id;
  LoginResponseModel({
    required this.id,
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
    // required this.province_id,
    // required this.district_id,
    // required this.muni_id
  });

  // toMap() => {
  //       id: id,
  //       fullName: fullName,
  //     };

  // factory LoginResponseModel.fromDb(Map json) => LoginResponseModel(id: json['id'], fullName: json['fullName'], address: "address", email: "email", password: "password", enrollment: enrollment, userType: userType, lifeMember: lifeMember, status: status, memberId: memberId, registerDate: registerDate, countryId: countryId, fcmToken: fcmToken)

  // factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
  //     LoginResponseModel(
  //       id: json["id"] ?? 0,
  //       fullName: json["full_name"] ?? "",
  //       address: json["address"] ?? "",
  //       email: json["email"] ?? "",
  //       password: json["password"] ?? "",
  //       enrollment: json["enrollment"] ?? "",
  //       userType: json["user_type"] ?? "",
  //       lifeMember: json["life_member"] ?? "",
  //       status: json["status"] ?? "",
  //       memberId: json["member_id"] ?? "",
  //       registerDate: json["register_date"] ?? "",
  //       countryId: json["country_id"] ?? 0,
  //       fcmToken: json["fcm_token"] ?? "",
  //     );

  LoginResponseModel copyWith({
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
    // int? province_id,
    // int? district_id,
    // int? muni_id,
  }) {
    return LoginResponseModel(
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
      // province_id: province_id ?? this.province_id,
      // district_id: district_id ?? this.district_id,
      // muni_id: muni_id ?? this.muni_id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'fullName': fullName,
      'address': address,
      'email': email,
      'password': password,
      'enrollment': enrollment,
      'userType': userType,
      'lifeMember': lifeMember,
      'status': status,
      'memberId': memberId,
      'registerDate': registerDate,
      'countryId': countryId,
      'fcmToken': fcmToken,
      // 'province_id': province_id,
      // 'district_id': district_id,
      // 'muni_id': muni_id,
    };
  }

  // factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
  //   return LoginResponseModel(
  //     id: map['id'] as int,
  //     fullName: map['fullName'] as String,
  //     address: map['address'] as String,
  //     email: map['email'] as String,
  //     password: map['password'] as String,
  //     enrollment: map['enrollment'] as String,
  //     userType: map['userType'] as String,
  //     lifeMember: map['lifeMember'] as String,
  //     status: map['status'] as String,
  //     memberId: map['memberId'] as String,
  //     registerDate: map['registerDate'] as String,
  //     countryId: map['countryId'] as int,
  //     fcmToken: map['fcmToken'] as String,
  //   );
  // }

  factory LoginResponseModel.fromMap(Map<String, dynamic> json) =>
      LoginResponseModel(
        id: json["id"] ?? 0,
        fullName: json["full_name"] ?? "",
        address: json["address"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        enrollment: json["enrollment"] ?? "",
        userType: json["user_type"] ?? "",
        lifeMember: json["life_member"] ?? "",
        status: json["status"] ?? "",
        memberId: json["member_id"] ?? "",
        registerDate: json["register_date"] ?? "",
        countryId: json["country_id"] ?? "",
        fcmToken: json["fcm_token"] ?? "",
        // province_id: json["province_id"] ?? json["country_id"] ?? 0,
        // district_id: json["district_id"] ?? json["country_id"] ?? 0,
        // muni_id: json["muni_id"] ?? json["country_id"] ?? 0,
      );
  String toJson() => json.encode(toMap());

  factory LoginResponseModel.fromJson(String source) =>
      LoginResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'LoginResponseModel(id: $id, fullName: $fullName, address: $address, email: $email, password: $password, enrollment: $enrollment, userType: $userType, lifeMember: $lifeMember, status: $status, memberId: $memberId, registerDate: $registerDate, countryId: $countryId, fcmToken: $fcmToken, )';
    // return 'LoginResponseModel(id: $id, fullName: $fullName, address: $address, email: $email, password: $password, enrollment: $enrollment, userType: $userType, lifeMember: $lifeMember, status: $status, memberId: $memberId, registerDate: $registerDate, countryId: $countryId, fcmToken: $fcmToken, province_id: $province_id, district_id: $district_id, muni_id: $muni_id)';
  }

  @override
  bool operator ==(covariant LoginResponseModel other) {
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
        other.fcmToken == fcmToken;
    //  &&
    // other.province_id == province_id &&
    // other.district_id == district_id &&
    // other.muni_id == muni_id;
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
        fcmToken.hashCode;
    // province_id.hashCode ^
    // district_id.hashCode ^
    // muni_id.hashCode;
  }

  // factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
  //   return LoginResponseModel(
  //     id: map['id'] as int,
  //     fullName: map['fullName'] as String,
  //     address: map['address'] as String,
  //     email: map['email'] as String,
  //     password: map['password'] as String,
  //     enrollment: map['enrollment'] as String,
  //     userType: map['userType'] as String,
  //     lifeMember: map['lifeMember'] as String,
  //     status: map['status'] as String,
  //     memberId: map['memberId'] as String,
  //     registerDate: map['registerDate'] as String,
  //     countryId: map['countryId'] as int,
  //     fcmToken: map['fcmToken'] as String,
  //     province_id: map['province_id'] as int,
  //     district_id: map['district_id'] as int,
  //     muni_id: map['muni_id'] as int,
  //   );
  // }
}
