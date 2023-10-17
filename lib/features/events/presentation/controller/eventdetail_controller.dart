import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/events/data/models/event_detail_model.dart';
import 'package:nelta/features/events/data/repositories/event_repositories.dart';

class EventDetailController
    extends StateNotifier<AsyncValue<EventDetailModel>> {
  final EventRepository eventRepository;
  final String id;
  EventDetailController({required this.eventRepository, required this.id})
      : super(const AsyncValue.loading()) {
    getConferenceSubHeadingList();
  }

  getConferenceSubHeadingList() async {
    final result = await eventRepository.getEventDetailRepo(id);
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final eventDetailControllerProvider = StateNotifierProvider.family
    .autoDispose<EventDetailController, AsyncValue<EventDetailModel>, String>(
        (ref, id) {
  return EventDetailController(
      eventRepository: ref.read(
        eventRepositoryProvider,
      ),
      id: id);
});
