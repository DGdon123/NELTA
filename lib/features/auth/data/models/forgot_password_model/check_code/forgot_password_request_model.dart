class ForgotPasswordRequestModel {
  final String email;
  final int? is_member;

  ForgotPasswordRequestModel({required this.email, required this.is_member});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'is_member': is_member,
    };
  }
}
