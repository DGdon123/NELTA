import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/events/data/models/event_detail_model.dart';
import 'package:nelta/features/events/data/models/eventlist_model.dart';

abstract class EventDataSource {
  Future<List<EventModel>> getEventListDS();
  Future<EventDetailModel> getEventDetailDS(String id);
}

class EventDataSourceimpl implements EventDataSource {
  final ApiClient apiClient;
  EventDataSourceimpl(this.apiClient);

  @override
  Future<List<EventModel>> getEventListDS() async {
    final result = await apiClient.request(path: ApiConst.events);
    List data = result["events"];
    return data.map((e) => EventModel.fromMap(e)).toList();
  }

  @override
  Future<EventDetailModel> getEventDetailDS(String id) async {
    final result = await apiClient.request(path: ApiConst.eventID + id);
    return EventDetailModel.fromJson(result["event"]);
  }
}

final eventDataSourceProvider = Provider<EventDataSource>((ref) {
  return EventDataSourceimpl(ref.read(apiClientProvider));
});
