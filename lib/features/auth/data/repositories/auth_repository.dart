import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/auth/data/data_source/auth_data_source.dart';
import 'package:nelta/features/auth/data/models/countries_list_model.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/check_code/check_code_request_model.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/check_code/check_code_response_model.dart';
import 'package:nelta/features/auth/data/models/forgot_password_model/set_new_password/setnew_password_response_model.dart';
import 'package:nelta/features/auth/data/models/signmodel/sign_upmodel.dart';
import '../models/change_password_model/change_password_response_model.dart';
import '../models/change_password_model/password_change_respones_model.dart';
import '../models/forgot_password_model/check_code/forgot_password_request_model.dart';
import '../models/forgot_password_model/check_code/forgot_password_response_model.dart';
import '../models/forgot_password_model/set_new_password/setnew_password_request_model.dart';
import '../models/login model/login_request_model.dart';
import '../models/login model/login_response_model.dart';

abstract class AuthRepositories {
  //LoginRepo
  Future<Either<AppError, LoginResponseModel>> loginRepo(
      LoginRequestModel loginRequestModel, String token);
  //SingUpRepo
  Future<Either<AppError, LoginResponseModel>> singUpRepo(
      SignUpRequestModel signUpRequestModel, String token);
  //GetCountriesList
  Future<Either<AppError, List<CountryModel>>> getCountriesListRepo(
      String token);

  //Reset Password repo
  Future<Either<AppError, ChangePasswordResponseModel>> changePasswordRepo(
      PasswordChnageRequestModel passwordChnageRequestModel);

  //Reset Password-requestcode
  Future<Either<AppError, ForgotPasswordResponseModel>>
      getCodePasswordForgotRepo(
          {required ForgotPasswordRequestModel forgotPasswordRequestModel,
          required String token});

  //Reset Password-checkcode
  Future<Either<AppError, CheckCodeForgotPasswordResponseModel>>
      checkCodePasswordForgotRepo(
          {required CheckCodeForgotPasswordRequestModel
              checkCodeForgotPasswordRequestModel,
          required String token});

  //Reset Password-updatePassword
  Future<Either<AppError, SetNewsPasswordFGResponseModel>> setNewPasswordRepo(
      {required SetPasswordRequestModel setPasswordRequestModel,
      required String token});
}

class AuthRepositoriesImp implements AuthRepositories {
  final AuthDataSource authDataSource;
  AuthRepositoriesImp(this.authDataSource);
  @override
  Future<Either<AppError, LoginResponseModel>> loginRepo(
      LoginRequestModel loginRequestModel, String token) async {
    try {
      final result = await authDataSource.loginDS(loginRequestModel, token);
      return Right(result);
    } on DioException catch (e) {
      log(e.toString());
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, LoginResponseModel>> singUpRepo(
      SignUpRequestModel signUpRequestModel, String token) async {
    try {
      final result = await authDataSource.singUpDS(signUpRequestModel, token);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, List<CountryModel>>> getCountriesListRepo(
      String token) async {
    try {
      final result = await authDataSource.getCountriesListDS(token);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, ChangePasswordResponseModel>> changePasswordRepo(
    PasswordChnageRequestModel passwordChnageRequestModel,
  ) async {
    try {
      final result = await authDataSource.changePasswordDS(
        passwordChnageRequestModel,
      );
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, ForgotPasswordResponseModel>>
      getCodePasswordForgotRepo(
          {required ForgotPasswordRequestModel forgotPasswordRequestModel,
          required String token}) async {
    try {
      final result = await authDataSource.getCodePasswordForgot(
          forgotPasswordRequestModel: forgotPasswordRequestModel, token: token);

      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, CheckCodeForgotPasswordResponseModel>>
      checkCodePasswordForgotRepo(
          {required CheckCodeForgotPasswordRequestModel
              checkCodeForgotPasswordRequestModel,
          required String token}) async {
    try {
      final result = await authDataSource.checkCodePasswordForgotDS(
          checkCodeForgotPasswordRequestModel:
              checkCodeForgotPasswordRequestModel,
          token: token);

      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, SetNewsPasswordFGResponseModel>> setNewPasswordRepo(
      {required SetPasswordRequestModel setPasswordRequestModel,
      required String token}) async {
    try {
      final result = await authDataSource.setNewPasswordDS(
          setPasswordRequestModel: setPasswordRequestModel, token: token);

      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final authRepositoriesProvider = Provider<AuthRepositories>((ref) {
  return AuthRepositoriesImp(ref.read(authDataSourceProvider));
});
