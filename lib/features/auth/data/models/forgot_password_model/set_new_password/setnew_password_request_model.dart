class SetPasswordRequestModel {
  final String email;
    final String password;
  final int? is_member;

  SetPasswordRequestModel({required this.email, required this.is_member,required this.password});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'is_member': is_member,
      "password":password
    };
  }
}
