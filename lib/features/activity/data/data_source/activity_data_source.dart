import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/activity/data/models/activity_model.dart';

abstract class ActivityDataSource {
  Future<List<ActivityModel>> getActivityListDS();
}

class ActivityDataSourceimpl implements ActivityDataSource {
  final ApiClient apiClient;
  ActivityDataSourceimpl(this.apiClient);

  @override
  Future<List<ActivityModel>> getActivityListDS() async {
    final result = await apiClient.request(path: ApiConst.activities);
    List data = result["activities"];
    return data.map((e) => ActivityModel.fromJson(e)).toList();
  }
}

final activityDataSourceProvider = Provider<ActivityDataSource>((ref) {
  return ActivityDataSourceimpl(ref.read(apiClientProvider));
});
