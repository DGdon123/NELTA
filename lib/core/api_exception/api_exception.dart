// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dio/dio.dart';

class DioException implements Exception {
  DioException.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.unknown:
        message = "Connection failed due to internet connection";
        break;
      case DioErrorType.badResponse:
        message = _handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String? message;

  String _handleError(int statuscode, dynamic error) {
    switch (statuscode) {
      case 400:
        return error["message"] ??
            error["success"] ??
            error["email"] ??
            "Error";
      case 401:
        return error["message"] ?? "error";
      case 404:
        return error["message"] ?? error["error"] ?? "Not found";
      case 406:
        return error["message"] ?? error["error"] ?? "Error";
      case 422:
        return error["message"] != null && error["errors"] != null
            ? SignUpError.fromJson(error["errors"]).errormethod()
            : error["message"] ?? "Something went wrong";
      case 500:
        return "Internal server error";
      default:
        return "Something went wrong";
    }
  }
}

class SignUpError {
  String username;
  String email;
  String phone;
  SignUpError({
    required this.username,
    required this.email,
    required this.phone,
  });
  String? errormethod() {
    if (username.isEmpty && email.isEmpty) return phone;
    if (username.isEmpty && phone.isEmpty) return email;
    if (phone.isEmpty && email.isEmpty) return username;

    if (username.isNotEmpty && email.isNotEmpty && phone.isNotEmpty) {
      return "The username, email and mobile is already taken.";
    }
    if (username.isNotEmpty && email.isNotEmpty && phone.isEmpty) {
      return "The username and email is already taken.";
    }
    if (username.isNotEmpty && email.isEmpty && phone.isNotEmpty) {
      return "The username and mobile is already taken.";
    }
    if (username.isEmpty && email.isNotEmpty && phone.isNotEmpty) {
      return "The email and mobile is already taken.";
    }

    return null;
  }

  factory SignUpError.fromJson(Map<String, dynamic> json) {
    return SignUpError(
      username: json["username"] != null ? json["username"][0] : "",
      email: json["email"] != null ? json["email"][0] : "",
      phone: json["mobile"] != null ? json["mobile"][0] : "",
    );
  }
}
