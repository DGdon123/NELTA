import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/activity/data/models/activity_model.dart';
import '../data_source/activity_data_source.dart';

abstract class ActivityRepositories {
  Future<Either<AppError, List<ActivityModel>>> getActivityRepo();
}

class ActivityRepositoriesImpl implements ActivityRepositories {
  final ActivityDataSource activitiyDataSource;
  ActivityRepositoriesImpl(this.activitiyDataSource);

  @override
  Future<Either<AppError, List<ActivityModel>>> getActivityRepo() async {
    try {
      final result = await activitiyDataSource.getActivityListDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final activityRepositoriesController = Provider<ActivityRepositories>((ref) {
  return ActivityRepositoriesImpl(ref.read(activityDataSourceProvider));
});
