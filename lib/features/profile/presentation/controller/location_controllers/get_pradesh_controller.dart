import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/profile/data/model/location_model/getpradesh_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';

class PradeshController extends StateNotifier<AsyncValue<PradeshModel>> {
  final ProfileRepository profileRepository;
  PradeshController({
    required this.profileRepository,
  }) : super(const AsyncValue.loading()) {
    getPradeshC();
  }
  getPradeshC() async {
    final result = await profileRepository.getPradeshRepo();
    return result.fold(
      (l) =>
          state = AsyncValue.error(l.message, StackTrace.fromString(l.message)),
      (r) {
        return state = AsyncValue.data(r);
      },
    );
  }
}

final pradeshController =
    StateNotifierProvider<PradeshController, AsyncValue<PradeshModel>>((ref) {
  return PradeshController(
      profileRepository: ref.read(profileRepositoryProvider));
});
