class LoginRequestModel {
  final String email;
  final String password;
  final int? is_member;
  LoginRequestModel({required this.email, required this.password,required this.is_member});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      "is_member":is_member
    };
  }
}
