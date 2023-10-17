import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/auth/data/models/countries_list_model.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/check_code/check_code_request_model.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/check_code/check_code_response_model.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/set_new_password/setnew_password_request_model.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/set_new_password/setnew_password_response_model.dart';
import '../models/change_password_model/change_password_response_model.dart';
import '../models/change_password_model/password_change_respones_model.dart';
import '../models/forgot_password_model/check_code/forgot_password_request_model.dart';
import '../models/forgot_password_model/check_code/forgot_password_response_model.dart';
import '../models/login model/login_request_model.dart';
import '../models/login model/login_response_model.dart';
import '../models/signmodel/sign_upmodel.dart';

abstract class AuthDataSource {
  Future<LoginResponseModel> loginDS(
      LoginRequestModel loginRequestModel, String token);
  Future<LoginResponseModel> singUpDS(
      SignUpRequestModel signUpRequestModel, String token);

  Future<ChangePasswordResponseModel> changePasswordDS(
      PasswordChnageRequestModel passwordChnageRequestModel);
  Future<List<CountryModel>> getCountriesListDS(String token);

//forgotPassword-getcode
  Future<ForgotPasswordResponseModel> getCodePasswordForgot(
      {required ForgotPasswordRequestModel forgotPasswordRequestModel,
      required String token});

//forgotPassword-checkCode
  Future<CheckCodeForgotPasswordResponseModel> checkCodePasswordForgotDS(
      {required CheckCodeForgotPasswordRequestModel
          checkCodeForgotPasswordRequestModel,
      required String token});

//forgotPassword-set new Password
  Future<SetNewsPasswordFGResponseModel> setNewPasswordDS(
      {required SetPasswordRequestModel setPasswordRequestModel,
      required String token});
}

class AuthDataSourceImp implements AuthDataSource {
  final ApiClient apiClient;
  AuthDataSourceImp(this.apiClient);

  @override
  Future<LoginResponseModel> loginDS(
      LoginRequestModel loginRequestModel, String token) async {
    final result = await apiClient.request(
        path: ApiConst.applogin,
        type: "post",
        data: loginRequestModel.toMap(),
        token: token);
    // log(result.toString());
    return LoginResponseModel.fromMap(result["app_user"]);
  }

  @override
  Future<LoginResponseModel> singUpDS(
      SignUpRequestModel signUpRequestModel, String token) async {
    // log(token.toString());
    final result = await apiClient.request(
        path: ApiConst.apiRegister,
        token: token,
        type: "post",
        data: signUpRequestModel.toMap());

    return LoginResponseModel.fromMap(result["app_user"]);
  }

  @override
  Future<List<CountryModel>> getCountriesListDS(String token) async {
    final result = await apiClient.request(
      path: ApiConst.countries,
      token: token,
    );
    List data = result["countries"];
    return data.map((e) => CountryModel.fromJson(e)).toList();
  }

  @override
  Future<ChangePasswordResponseModel> changePasswordDS(
    PasswordChnageRequestModel passwordChnageRequestModel,
  ) async {
    final result = await apiClient.request(
      path: ApiConst.changePasswordApi,
      type: "post",
      data: passwordChnageRequestModel.toMap(),
    );
    return ChangePasswordResponseModel.fromMap(result);
  }

  @override
  Future<ForgotPasswordResponseModel> getCodePasswordForgot(
      {required ForgotPasswordRequestModel forgotPasswordRequestModel,
      required String token}) async {
    final result = await apiClient.request(
        token: token,
        path: ApiConst.getCode,
        type: "post",
        data: forgotPasswordRequestModel.toMap());

    return ForgotPasswordResponseModel.fromMap(result);
  }

  @override
  Future<CheckCodeForgotPasswordResponseModel> checkCodePasswordForgotDS(
      {required CheckCodeForgotPasswordRequestModel
          checkCodeForgotPasswordRequestModel,
      required String token}) async {
    final result = await apiClient.request(
        token: token,
        path: ApiConst.checkcode,
        type: "post",
        data: checkCodeForgotPasswordRequestModel.toMap());
    return CheckCodeForgotPasswordResponseModel.fromMap(result);
  }

  @override
  Future<SetNewsPasswordFGResponseModel> setNewPasswordDS(
      {required SetPasswordRequestModel setPasswordRequestModel,
      required String token}) async {
    final result = await apiClient.request(
        token: token,
        path: ApiConst.updateNewPassword,
        type: "post",
        data: setPasswordRequestModel.toMap());
    return SetNewsPasswordFGResponseModel.fromMap(result);
  }
}

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return AuthDataSourceImp(ref.read(apiClientProvider));
});
