import 'dart:convert';

class SetNewsPasswordFGResponseModel {
  final String success;
  SetNewsPasswordFGResponseModel({
    required this.success,
  });

  SetNewsPasswordFGResponseModel copyWith({
    String? success,
  }) {
    return SetNewsPasswordFGResponseModel(
      success: success ?? this.success,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
    };
  }

  factory SetNewsPasswordFGResponseModel.fromMap(Map<String, dynamic> map) {
    return SetNewsPasswordFGResponseModel(
      success: map['success'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SetNewsPasswordFGResponseModel.fromJson(String source) =>
      SetNewsPasswordFGResponseModel.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SetNewsPasswordFGResponseModel(success: $success)';

  @override
  bool operator ==(covariant SetNewsPasswordFGResponseModel other) {
    if (identical(this, other)) return true;

    return other.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}
