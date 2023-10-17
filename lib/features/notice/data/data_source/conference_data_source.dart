import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/notice/data/models/notice_model.dart';

abstract class NoticeDataSource {
  // Future<List<ConferenceModel>> getConferenceListDS();
  // Future<List<EventModel>> getEventListDS();
  Future<List<NoticesModel>> getNoticesListDS();
  // Future<List<ActivityModel>> getActivityListDS();
  // Future<List<BranchModel>> getBranhListDS();
  // Future<List<ConferenceSubHeadingModel>> getConferenceSubHeading(String id);
  // Future<ConferenceSubHeadinDetail> getConferenceSubHeadingDetail(String id);
}

class NoticeDataSourceimpl implements NoticeDataSource {
  final ApiClient apiClient;
  NoticeDataSourceimpl(this.apiClient);

  // @override
  // Future<List<EventModel>> getEventListDS() async {
  //   final result = await apiClient.request(path: ApiConst.events);
  //   List data = result["events"];
  //   return data.map((e) => EventModel.fromMap(e)).toList();
  // }

  @override
  Future<List<NoticesModel>> getNoticesListDS() async {
    final result = await apiClient.request(path: ApiConst.notice);
    List data = result["notices"];
    return data.map((e) => NoticesModel.fromJson(e)).toList();
  }
}

final noticeDataSourceProvider = Provider<NoticeDataSource>((ref) {
  return NoticeDataSourceimpl(ref.read(apiClientProvider));
});
