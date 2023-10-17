import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/notice/data/data_source/conference_data_source.dart';
import 'package:nelta/features/notice/data/models/notice_model.dart';

abstract class NoticeRepository {
  // Future<Either<AppError, List<ConferenceModel>>> getConferenceListRepo();
  // Future<Either<AppError, List<EventModel>>> getEventListRepo();
  Future<Either<AppError, List<NoticesModel>>> getNoticeListRepo();
}

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeDataSource noticeDataSource;
  NoticeRepositoryImpl(this.noticeDataSource);

  @override
  Future<Either<AppError, List<NoticesModel>>> getNoticeListRepo() async {
    try {
      final result = await noticeDataSource.getNoticesListDS();
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final noticeListRepositoryProvider = Provider<NoticeRepository>((ref) {
  return NoticeRepositoryImpl(ref.read(noticeDataSourceProvider));
});
