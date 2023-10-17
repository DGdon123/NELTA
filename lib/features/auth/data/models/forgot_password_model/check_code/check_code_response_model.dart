import 'dart:convert';

class CheckCodeForgotPasswordResponseModel {
  final String success;
  CheckCodeForgotPasswordResponseModel({
    required this.success,
  });

  CheckCodeForgotPasswordResponseModel copyWith({
    String? success,
  }) {
    return CheckCodeForgotPasswordResponseModel(
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
    };
  }

  factory CheckCodeForgotPasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return CheckCodeForgotPasswordResponseModel(
      success: map['success'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CheckCodeForgotPasswordResponseModel.fromJson(String source) =>
      CheckCodeForgotPasswordResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CheckCodeForgotPasswordResponseModel(success: $success)';

  @override
  bool operator ==(covariant CheckCodeForgotPasswordResponseModel other) {
    if (identical(this, other)) return true;

    return other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}
