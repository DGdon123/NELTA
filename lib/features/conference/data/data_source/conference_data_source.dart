import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
// import 'package:nelta/features/activity/data/models/activity_model.dart';
import 'package:nelta/features/conference/data/model/branch_model.dart';
import 'package:nelta/features/conference/data/model/conference_model.dart';
import 'package:nelta/features/conference/data/model/conferencesub_detailmodel.dart';
import 'package:nelta/features/conference/data/model/conferencesub_titlemodel.dart';

abstract class ConferenceDataSource {
  Future<List<ConferenceModel>> getConferenceListDS();
  // Future<List<EventModel>> getEventListDS();
  // Future<List<NoticesModel>> getNoticesListDS();
  // Future<List<ActivityModel>> getActivityListDS();
  Future<List<BranchModel>> getBranhListDS();
  Future<List<ConferenceSubHeadingModel>> getConferenceSubHeading(String id);
  Future<ConferenceSubHeadinDetail> getConferenceSubHeadingDetail(String id);
}

class ConferenceDataSourceimpl implements ConferenceDataSource {
  final ApiClient apiClient;
  ConferenceDataSourceimpl(this.apiClient);
  @override
  Future<List<ConferenceModel>> getConferenceListDS() async {
    final result = await apiClient.request(path: ApiConst.conference);
    List data = result["conference"];
    return data.map((e) => ConferenceModel.fromJson(e)).toList();
  }

  // @override
  // Future<List<EventModel>> getEventListDS() async {
  //   final result = await apiClient.request(path: ApiConst.events);
  //   List data = result["events"];
  //   return data.map((e) => EventModel.fromMap(e)).toList();
  // }



  // @override
  // Future<List<ActivityModel>> getActivityListDS() async {
  //   final result = await apiClient.request(path: ApiConst.activities);
  //   List data = result["activities"];
  //   return data.map((e) => ActivityModel.fromJson(e)).toList();
  // }

  @override
  Future<List<BranchModel>> getBranhListDS() async {
    final result = await apiClient.request(path: ApiConst.branch);
    List data = result["branches"];
    return data.map((e) => BranchModel.fromJson(e)).toList();
  }

  @override
  Future<List<ConferenceSubHeadingModel>> getConferenceSubHeading(
      String id) async {
    final result =
        await apiClient.request(path: ApiConst.conferenceSubHeadindId + id);
    List data = result["titles"];
    return data.map((e) => ConferenceSubHeadingModel.fromJson(e)).toList();
  }

  @override
  Future<ConferenceSubHeadinDetail> getConferenceSubHeadingDetail(
      String id) async {
    final result = await apiClient.request(
        path: ApiConst.conferenceSubHeadingDetailId + id);
    // log(result["conference_detail"]);
    return ConferenceSubHeadinDetail.fromJson(result["conference_detail"]);
  }
}

final conferenceDataSourceProvider = Provider<ConferenceDataSource>((ref) {
  return ConferenceDataSourceimpl(ref.read(apiClientProvider));
});
