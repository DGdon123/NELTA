import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/resources/data/data_source/resources_datasource.dart';
import '../model/resouces_down_model.dart';
import '../model/resources_model.dart';

abstract class ResoucesRepositories {
  Future<Either<AppError, List<ResoucesModel>>> getResourcesRepo();
  Future<Either<AppError, List<ResourceDownloadModel>>> getResourcesDetailRepo(
      String id);
}

class ResoucesRepositoriesImpl implements ResoucesRepositories {
  final ResoucesDataSource resoucesDataSource;
  ResoucesRepositoriesImpl(this.resoucesDataSource);

  @override
  Future<Either<AppError, List<ResoucesModel>>> getResourcesRepo() async {
    try {
      final result = await resoucesDataSource.getResourcesDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, List<ResourceDownloadModel>>> getResourcesDetailRepo(
      String id) async {
    try {
      final result = await resoucesDataSource.getResourcesDetailDS(id);
      // log(result.toString());
      return Right(result);
    } on DioException catch (e) {
      log(e.message.toString());
      return Left(AppError(e.message!));
    }
  }
}

final resoucesRepositoriesProvider = Provider<ResoucesRepositories>((ref) {
  return ResoucesRepositoriesImpl(ref.read(resoucesDataSourceProvider));
});
