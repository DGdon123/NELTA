import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/conference/data/model/conference_model.dart';
import 'package:nelta/features/conference/data/repositories/conference_repository.dart';

class ConferenceListController
    extends StateNotifier<AsyncValue<List<ConferenceModel>>> {
  final ConferenceRepository conferenceRepository;
  ConferenceListController({required this.conferenceRepository})
      : super(const AsyncValue.loading()) {
    getconferenceList();
  }

  getconferenceList() async {
    final result = await conferenceRepository.getConferenceListRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final conferenceListControllerProvider = StateNotifierProvider<
    ConferenceListController, AsyncValue<List<ConferenceModel>>>((ref) {
  return ConferenceListController(
      conferenceRepository: ref.read(conferenceListRepoProvider));
});
