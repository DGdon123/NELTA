import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/profile/data/data_source/profile_data_source.dart';
import 'package:nelta/features/profile/data/model/location_model/getdistrict_model.dart';
import 'package:nelta/features/profile/data/model/location_model/getmuni_model.dart';
import 'package:nelta/features/profile/data/model/location_model/getpradesh_model.dart';
import 'package:nelta/features/profile/data/model/member_models/member_profile_model.dart';
import 'package:nelta/features/profile/data/model/member_models/member_profile_update_response_model.dart';
import 'package:nelta/features/profile/data/model/member_models/member_update_request_model.dart';
import 'package:nelta/features/profile/data/model/user_models/profile_response_model.dart';
import 'package:nelta/features/profile/data/model/user_models/update_profile_response_model.dart';

abstract class ProfileRepository {
  //Location
  Future<Either<AppError, District>> getDistrictRepo();
  Future<Either<AppError, PradeshModel>> getPradeshRepo();
  Future<Either<AppError, MunicipalityModel>> getMunicpalityRepo();
//Member
  Future<Either<AppError, MemberProfileResponseModel>> getMemberProfileRepo();
  Future<Either<AppError, MemberProfileUpdateResponseModel>>
      updateMemberProfileRepo(
          MemberUpdateRequestModel memberUpdateRequestModel);
  Future<Either<AppError, MemberProfileUpdateResponseModel>>
      updateMemberProfileFormDataRepo(FormData formData);
//User

  Future<Either<AppError, ProfileResponseModel>> getUserProfileRepo();
  Future<Either<AppError, ProfileUpdateResponseModel>> updateUserProfileRepo(
      FormData formData);

//AddressList
  Future<Either<AppError, List<PradeshModel>>> getPradeshListRepo();
  Future<Either<AppError, List<District>>> getDistrictListRepo(String id);
  Future<Either<AppError, List<MunicipalityModel>>> getMunicipalityListRepo(
      String id);
}

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource profileDataSource;
  ProfileRepositoryImpl(this.profileDataSource);

  @override
  Future<Either<AppError, ProfileResponseModel>> getUserProfileRepo() async {
    try {
      final result = await profileDataSource.getUserProfileDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, ProfileUpdateResponseModel>> updateUserProfileRepo(
      FormData formData) async {
    try {
      final result = await profileDataSource.updateUserProfileDS(formData);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, MemberProfileResponseModel>>
      getMemberProfileRepo() async {
    try {
      final result = await profileDataSource.getMemberProfileDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, District>> getDistrictRepo() async {
    try {
      final result = await profileDataSource.getDistrictDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, PradeshModel>> getPradeshRepo() async {
    try {
      final result = await profileDataSource.getPradeshDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, MunicipalityModel>> getMunicpalityRepo() async {
    try {
      final result = await profileDataSource.getMunicpalityDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, MemberProfileUpdateResponseModel>>
      updateMemberProfileRepo(
          MemberUpdateRequestModel memberUpdateRequestModel) async {
    try {
      final result = await profileDataSource
          .updateMemberProfileDS(memberUpdateRequestModel);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, List<PradeshModel>>> getPradeshListRepo() async {
    try {
      final result = await profileDataSource.getPradeshListDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, List<District>>> getDistrictListRepo(
      String id) async {
    try {
      final result = await profileDataSource.getDistrictListDS(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, List<MunicipalityModel>>> getMunicipalityListRepo(
      String id) async {
    try {
      final result = await profileDataSource.getMunicipalityListDs(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, MemberProfileUpdateResponseModel>>
      updateMemberProfileFormDataRepo(FormData formData) async {
    try {
      final result =
          await profileDataSource.updateMemberProfileFormDataDS(formData);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepositoryImpl(ref.read(profileDataSourceProvider));
});
