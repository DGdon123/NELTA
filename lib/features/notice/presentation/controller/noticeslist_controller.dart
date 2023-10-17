import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/notice/data/models/notice_model.dart';
import 'package:nelta/features/notice/data/repositories/notice_repositories.dart';

class NoticesListController
    extends StateNotifier<AsyncValue<List<NoticesModel>>> {
  final NoticeRepository noticeRepository;
  NoticesListController({required this.noticeRepository})
      : super(const AsyncValue.loading()) {
    getNoticesList();
  }

  getNoticesList() async {
    final result = await noticeRepository.getNoticeListRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

// final noticesListControllerProvider = StateNotifierProvider<
//     NoticesListController, AsyncValue<List<NoticesModel>>>((ref) {
//   return NoticesListController(
//       noticeRepository: ref.read(noticeListRepositoryProvider));
// });

final noticeListContollerProvider = StateNotifierProvider<NoticesListController,
    AsyncValue<List<NoticesModel>>>((ref) {
  return NoticesListController(
      noticeRepository: ref.read(noticeListRepositoryProvider));
});
