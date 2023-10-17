import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/events/data/models/eventlist_model.dart';
import 'package:nelta/features/events/data/repositories/event_repositories.dart';

class ConferenceListController
    extends StateNotifier<AsyncValue<List<EventModel>>> {
  final EventRepository eventRepository;
  ConferenceListController({required this.eventRepository})
      : super(const AsyncValue.loading()) {
    getEventList();
  }

  getEventList() async {
    final result = await eventRepository.getEventListRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final eventListController = StateNotifierProvider<ConferenceListController,
    AsyncValue<List<EventModel>>>((ref) {
  return ConferenceListController(
      eventRepository: ref.read(eventRepositoryProvider));
});
