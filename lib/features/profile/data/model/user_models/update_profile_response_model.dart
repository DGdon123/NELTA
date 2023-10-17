// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProfileUpdateResponseModel {
  String success;
  ProfileUpdateResponseModel({
    required this.success,
  });

  factory ProfileUpdateResponseModel.fromMap(Map<String, dynamic> map) {
    return ProfileUpdateResponseModel(
      success: map['success'] ?? "",
    );
  }
}
