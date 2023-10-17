class PasswordChnageRequestModel {
  final String email;
  final String password;
  final int? is_member;
  final String oldPassword;

  PasswordChnageRequestModel(
      {required this.email, required this.password, required this.is_member,required this.oldPassword});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
      "is_member": is_member,
      "old_password":oldPassword
    };
  }
}
