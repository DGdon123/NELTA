import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/mou_partner/data/data_source/mou_datasource.dart';
import 'package:nelta/features/mou_partner/data/model/mou_model.dart';

abstract class MouPartnerRepository {
  Future<Either<AppError, List<MouPartnerModel>>> getMouPartnerRepo();
}

class MouPartnerRepositoryImpl implements MouPartnerRepository {
  final MouPartnerDataSource mouPartnerDataSource;
  MouPartnerRepositoryImpl(this.mouPartnerDataSource);

  @override
  Future<Either<AppError, List<MouPartnerModel>>> getMouPartnerRepo() async {
    try {
      final result = await mouPartnerDataSource.getMouPartnerDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final mouPartnerRepositoryController = Provider<MouPartnerRepository>((ref) {
  return MouPartnerRepositoryImpl(ref.read(mouPartnerDataSourceProvider));
});
