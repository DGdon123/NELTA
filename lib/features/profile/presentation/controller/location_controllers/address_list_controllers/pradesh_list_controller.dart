import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/profile/data/model/location_model/getpradesh_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';

class PradeshListController
    extends StateNotifier<AsyncValue<List<PradeshModel>>> {
  final ProfileRepository profileRepository;
  PradeshListController({required this.profileRepository})
      : super(const AsyncValue.loading()) {
    getNoticesList();
  }

  getNoticesList() async {
    final result = await profileRepository.getPradeshListRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final pradeshListControllerProvider = StateNotifierProvider<
    PradeshListController, AsyncValue<List<PradeshModel>>>((ref) {
  return PradeshListController(
      profileRepository: ref.read(profileRepositoryProvider));
});
