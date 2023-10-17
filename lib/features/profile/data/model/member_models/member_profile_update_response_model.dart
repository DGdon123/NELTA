// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MemberProfileUpdateResponseModel {
  final String success;

  MemberProfileUpdateResponseModel(
    this.success,
  );

  MemberProfileUpdateResponseModel copyWith({
    String? success,
  }) {
    return MemberProfileUpdateResponseModel(
      success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
    };
  }

  factory MemberProfileUpdateResponseModel.fromMap(Map<String, dynamic> map) {
    return MemberProfileUpdateResponseModel(
      map['success'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MemberProfileUpdateResponseModel.fromJson(String source) => MemberProfileUpdateResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'MemberProfileUpdateResponseModel(success: $success)';

  @override
  bool operator ==(covariant MemberProfileUpdateResponseModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}
