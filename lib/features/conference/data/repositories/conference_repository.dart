import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/conference/data/data_source/conference_data_source.dart';
// import 'package:nelta/features/activity/data/models/activity_model.dart';
import 'package:nelta/features/conference/data/model/branch_model.dart';
import 'package:nelta/features/conference/data/model/conferencesub_detailmodel.dart';
import 'package:nelta/features/conference/data/model/conferencesub_titlemodel.dart';
import '../model/conference_model.dart';

abstract class ConferenceRepository {
  Future<Either<AppError, List<ConferenceModel>>> getConferenceListRepo();
  // Future<Either<AppError, List<EventModel>>> getEventListRepo();

  // Future<Either<AppError, List<ActivityModel>>> getActivityRepo();
  Future<Either<AppError, List<BranchModel>>> getBranchListRepo();
  Future<Either<AppError, List<ConferenceSubHeadingModel>>>
      getConferenceSubHadingRepo(String id);
  Future<Either<AppError, ConferenceSubHeadinDetail>>
      getConferenceSubHeadingDetailRepo(String id);
}

class ConferenceRepositoryImpl implements ConferenceRepository {
  final ConferenceDataSource conferenceDataSource;
  ConferenceRepositoryImpl(this.conferenceDataSource);
  @override
  Future<Either<AppError, List<ConferenceModel>>>
      getConferenceListRepo() async {
    try {
      final result = await conferenceDataSource.getConferenceListDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  // @override
  // Future<Either<AppError, List<ActivityModel>>> getActivityRepo() async {
  //   try {
  //     final result = await conferenceDataSource.getActivityListDS();
  //     return Right(result);
  //   } on DioException catch (e) {
  //     return Left(AppError(e.message!));
  //   }
  // }

  @override
  Future<Either<AppError, List<BranchModel>>> getBranchListRepo() async {
    try {
      final result = await conferenceDataSource.getBranhListDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, List<ConferenceSubHeadingModel>>>
      getConferenceSubHadingRepo(String id) async {
    try {
      final result = await conferenceDataSource.getConferenceSubHeading(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, ConferenceSubHeadinDetail>>
      getConferenceSubHeadingDetailRepo(String id) async {
    try {
      final result =
          await conferenceDataSource.getConferenceSubHeadingDetail(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final conferenceListRepoProvider = Provider<ConferenceRepository>((ref) {
  return ConferenceRepositoryImpl(ref.read(conferenceDataSourceProvider));
});
