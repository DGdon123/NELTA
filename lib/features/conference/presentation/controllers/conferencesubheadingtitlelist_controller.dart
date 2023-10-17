import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/conference/data/model/conferencesub_titlemodel.dart';
import 'package:nelta/features/conference/data/repositories/conference_repository.dart';

class ConferencceSubHeadingListController
    extends StateNotifier<AsyncValue<List<ConferenceSubHeadingModel>>> {
  final ConferenceRepository conferenceRepository;
  final String id;
  ConferencceSubHeadingListController(
      {required this.conferenceRepository, required this.id})
      : super(const AsyncValue.loading()) {
    getConferenceSubHeadingList();
  }

  getConferenceSubHeadingList() async {
    final result = await conferenceRepository.getConferenceSubHadingRepo(id);
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final conferencceSubHeadingListControllerProvider = StateNotifierProvider.family
    .autoDispose<ConferencceSubHeadingListController,
        AsyncValue<List<ConferenceSubHeadingModel>>, String>((ref, id) {
  return ConferencceSubHeadingListController(
      conferenceRepository: ref.read(
        conferenceListRepoProvider,
      ),
      id: id);
});
