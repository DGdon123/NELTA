import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/events/data/data_source/event_data_source.dart';
import 'package:nelta/features/events/data/models/event_detail_model.dart';
import 'package:nelta/features/events/data/models/eventlist_model.dart';

abstract class EventRepository {
  Future<Either<AppError, List<EventModel>>> getEventListRepo();
  Future<Either<AppError, EventDetailModel>> getEventDetailRepo(String id);
}

class EventRepositoryImpl implements EventRepository {
  final EventDataSource eventDataSource;
  EventRepositoryImpl(this.eventDataSource);

  @override
  Future<Either<AppError, List<EventModel>>> getEventListRepo() async {
    try {
      final result = await eventDataSource.getEventListDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }

  @override
  Future<Either<AppError, EventDetailModel>> getEventDetailRepo(
      String id) async {
    try {
      final result = await eventDataSource.getEventDetailDS(id);
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final eventRepositoryProvider = Provider<EventRepository>((ref) {
  return EventRepositoryImpl(ref.read(eventDataSourceProvider));
});
