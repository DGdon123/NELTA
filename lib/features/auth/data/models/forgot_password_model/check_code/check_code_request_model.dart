class CheckCodeForgotPasswordRequestModel {
  final String email;
    final String reset_code;
  final int? is_member;

  CheckCodeForgotPasswordRequestModel({required this.email, required this.is_member,required this.reset_code});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'is_member': is_member,
      "reset_code":reset_code
    };
  }
}
