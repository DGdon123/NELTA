import 'dart:convert';

class ForgotPasswordResponseModel {
  final String success;
  ForgotPasswordResponseModel({
    required this.success,
  });

  ForgotPasswordResponseModel copyWith({
    String? success,
  }) {
    return ForgotPasswordResponseModel(
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
    };
  }

  factory ForgotPasswordResponseModel.fromMap(Map<String, dynamic> map) {
    return ForgotPasswordResponseModel(
      success: map['success'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ForgotPasswordResponseModel.fromJson(String source) =>
      ForgotPasswordResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ForgotPasswordResponseModel(success: $success)';

  @override
  bool operator ==(covariant ForgotPasswordResponseModel other) {
    if (identical(this, other)) return true;

    return other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}
