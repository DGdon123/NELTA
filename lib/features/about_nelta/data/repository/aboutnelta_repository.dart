import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/about_nelta/data/data_source/about_nelta_datasource.dart';
import 'package:nelta/features/about_nelta/data/model/about_nelta_model.dart';

abstract class AboutNeltaRepository {
  Future<Either<AppError, AboutNeltaModel>> getAboutNeltaRepo();
}

class AboutNeltaRepositoryImpl implements AboutNeltaRepository {
  final AboutNeltaDataSource aboutNeltaDataSource;
  AboutNeltaRepositoryImpl(this.aboutNeltaDataSource);

  @override
  Future<Either<AppError, AboutNeltaModel>> getAboutNeltaRepo() async {
    try {
      final result = await aboutNeltaDataSource.getAboutNeltaDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final aboutNeltaRepositoryController = Provider<AboutNeltaRepository>((ref) {
  return AboutNeltaRepositoryImpl(ref.read(aboutNeltaDataSourceProvider));
});
