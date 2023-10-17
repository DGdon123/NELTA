import 'dart:convert';

class TokenResponseModel {
  final String token;

  TokenResponseModel({
    required this.token,
  });

  TokenResponseModel copyWith({
    String? token,
  }) {
    return TokenResponseModel(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
    };
  }

  factory TokenResponseModel.fromMap(Map<String, dynamic> map) {
    return TokenResponseModel(
      token: map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenResponseModel.fromJson(String source) =>
      TokenResponseModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TokenResponseModel(token: $token)';

  @override
  bool operator ==(covariant TokenResponseModel other) {
    if (identical(this, other)) return true;

    return other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
