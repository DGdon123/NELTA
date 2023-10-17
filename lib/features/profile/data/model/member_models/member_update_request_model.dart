// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MemberUpdateRequestModel {
  final int province_id;
  final int district_id;
  final int muni_id;
  final String phone_no;
  final String fname;
  final String lname;
  final String address;
  final String ward_no;
  final String Gender;
  final String photo;

  MemberUpdateRequestModel(
      {required this.province_id,
      required this.district_id,
      required this.muni_id,
      required this.phone_no,
      required this.fname,
      required this.lname,
      required this.address,
      required this.ward_no,
      required this.Gender,
      required this.photo
      });

  MemberUpdateRequestModel copyWith({
    int? province_id,
    int? district_id,
    int? muni_id,
    String? phone_no,
    String? fname,
    String? lname,
    String? address,
    String? ward_no,
    String? Gender,
    String?photo
  }) {
    return MemberUpdateRequestModel(
      province_id: province_id ?? this.province_id,
      district_id: district_id ?? this.district_id,
      muni_id: muni_id ?? this.muni_id,
      phone_no: phone_no ?? this.phone_no,
      fname: fname ?? this.fname,
      lname: lname ?? this.lname,
      address: address ?? this.address,
      ward_no: ward_no ?? this.ward_no,
      Gender: Gender ?? this.Gender,
      photo:photo??this.photo
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'province_id': province_id,
      'district_id': district_id,
      'muni_id': muni_id,
      'phone_no': phone_no,
      'fname': fname,
      'lname': lname,
      'address': address,
      'ward_no': ward_no,
      'Gender': Gender,
      "photo":photo
    };
  }

  factory MemberUpdateRequestModel.fromMap(Map<String, dynamic> map) {
    return MemberUpdateRequestModel(
      province_id: map['province_id'] as int,
      district_id: map['district_id'] as int,
      muni_id: map['muni_id'] as int,
      phone_no: map['phone_no'] as String,
      fname: map['fname'] as String,
      lname: map['lname'] as String,
      address: map['address'] as String,
      ward_no: map['ward_no'] as String,
      Gender: map['Gender'] as String,
      photo:map["photo"] as String
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberUpdateRequestModel.fromJson(String source) =>
      MemberUpdateRequestModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MemberUpdateRequestModel(province_id: $province_id, district_id: $district_id, muni_id: $muni_id, phone_no: $phone_no, fname: $fname, lname: $lname, address: $address, ward_no: $ward_no, Gender: $Gender,photo:$photo)';
  }

  @override
  bool operator ==(covariant MemberUpdateRequestModel other) {
    if (identical(this, other)) return true;

    return other.province_id == province_id &&
        other.district_id == district_id &&
        other.muni_id == muni_id &&
        other.phone_no == phone_no &&
        other.fname == fname &&
        other.lname == lname &&
        other.address == address &&
        other.ward_no == ward_no &&
        other.photo==photo &&
        other.Gender == Gender;
  }

  @override
  int get hashCode {
    return province_id.hashCode ^
        district_id.hashCode ^
        muni_id.hashCode ^
        phone_no.hashCode ^
        fname.hashCode ^
        lname.hashCode ^
        address.hashCode ^
        ward_no.hashCode ^
        photo.hashCode^
        Gender.hashCode;
  }
}
