// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MemberProfileResponseModel {
  int id;
  String fname;
  String mname;
  String lname;
  String associateMembershipNumber;
  String membershipType;
  String email;
  String password;
  String phoneNo;
  String mobileNo;
  String institution;
  String branch;
  String address;
  String status;
  String photo;
  String provinceId;
  String districtId;
  String muniId;
  String ward_no;
  String Gender;

  MemberProfileResponseModel({
    required this.id,
    required this.fname,
    required this.mname,
    required this.lname,
    required this.associateMembershipNumber,
    required this.membershipType,
    required this.email,
    required this.password,
    required this.phoneNo,
    required this.mobileNo,
    required this.institution,
    required this.branch,
    required this.address,
    required this.status,
    required this.photo,
    required this.provinceId,
    required this.districtId,
    required this.muniId,
    required this.ward_no,
    required this.Gender,
  });

  MemberProfileResponseModel copyWith({
    int? id,
    String? fname,
    String? mname,
    String? lname,
    String? associateMembershipNumber,
    String? membershipType,
    String? email,
    String? password,
    String? phoneNo,
    String? mobileNo,
    String? institution,
    String? branch,
    String? address,
    String? status,
    String? photo,
    String? provinceId,
    String? districtId,
    String? muniId,
    String? ward_no,
    String? Gender,
  }) {
    return MemberProfileResponseModel(
      id: id ?? this.id,
      fname: fname ?? this.fname,
      mname: mname ?? this.mname,
      lname: lname ?? this.lname,
      associateMembershipNumber:
          associateMembershipNumber ?? this.associateMembershipNumber,
      membershipType: membershipType ?? this.membershipType,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNo: phoneNo ?? this.phoneNo,
      mobileNo: mobileNo ?? this.mobileNo,
      institution: institution ?? this.institution,
      branch: branch ?? this.branch,
      address: address ?? this.address,
      status: status ?? this.status,
      photo: photo ?? this.photo,
      provinceId: provinceId ?? this.provinceId,
      districtId: districtId ?? this.districtId,
      muniId: muniId ?? this.muniId,
      ward_no: ward_no ?? this.ward_no,
      Gender: Gender ?? this.Gender,
    );
  }

  Map<String, dynamic> toMap() => {
        "id": id,
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "associate_membership_number": associateMembershipNumber,
        "membership_type": membershipType,
        "email": email,
        "password": password,
        "phone_no": phoneNo,
        "mobile_no": mobileNo,
        "institution": institution,
        "branch": branch,
        "address": address,
        "status": status,
        "photo": photo,
        "province_id": provinceId,
        "district_id": districtId,
        "muni_id": muniId,
        "ward_no": ward_no,
        "Gender": Gender,
      };
  factory MemberProfileResponseModel.fromMap(Map<String, dynamic> map) {
    return MemberProfileResponseModel(
      id: map['id'] ?? 0,
      fname: map['fname'] ?? "",
      mname: map['mname'] ?? "",
      lname: map['lname'] ?? "",
      associateMembershipNumber: map['associate_membership_number'] ?? "",
      membershipType: map['membership_type'] ?? "",
      email: map['email'] ?? "",
      password: map['password'] ?? "",
      phoneNo: map['phone_no'] ?? "",
      mobileNo: map['mobile_no'] ?? "",
      institution: map['institution'] ?? "",
      branch: map['branch'] ?? "",
      address: map['address'] ?? "",
      status: map['status'] ?? "",
      photo: map['photo'] ?? "images/user_place_holder.png",
      provinceId: map['province_id'] ?? '',
      districtId: map['district_id'] ?? '',
      muniId: map['muni_id'] ?? "1",
      ward_no: map['ward_no'] ?? "",
      Gender: map['Gender'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberProfileResponseModel.fromJson(String source) =>
      MemberProfileResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MemberProfileResponseModel(id: $id, fname: $fname, mname: $mname, lname: $lname, associateMembershipNumber: $associateMembershipNumber, membershipType: $membershipType, email: $email, password: $password, phoneNo: $phoneNo, mobileNo: $mobileNo, institution: $institution, branch: $branch, address: $address, status: $status, photo: $photo, provinceId: $provinceId, districtId: $districtId, muniId: $muniId, Gender: $Gender, ward_no: $ward_no)';
  }

  @override
  bool operator ==(covariant MemberProfileResponseModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.fname == fname &&
        other.mname == mname &&
        other.lname == lname &&
        other.associateMembershipNumber == associateMembershipNumber &&
        other.membershipType == membershipType &&
        other.email == email &&
        other.password == password &&
        other.phoneNo == phoneNo &&
        other.mobileNo == mobileNo &&
        other.institution == institution &&
        other.branch == branch &&
        other.address == address &&
        other.status == status &&
        other.photo == photo &&
        other.provinceId == provinceId &&
        other.districtId == districtId &&
        other.muniId == muniId &&
        other.ward_no == ward_no &&
        other.Gender == Gender;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        fname.hashCode ^
        mname.hashCode ^
        lname.hashCode ^
        associateMembershipNumber.hashCode ^
        membershipType.hashCode ^
        email.hashCode ^
        password.hashCode ^
        phoneNo.hashCode ^
        mobileNo.hashCode ^
        institution.hashCode ^
        branch.hashCode ^
        address.hashCode ^
        status.hashCode ^
        photo.hashCode ^
        provinceId.hashCode ^
        districtId.hashCode ^
        muniId.hashCode ^
        ward_no.hashCode ^
        Gender.hashCode;
  }
}
