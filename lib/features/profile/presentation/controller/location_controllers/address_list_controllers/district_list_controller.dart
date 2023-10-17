import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/profile/data/model/location_model/getdistrict_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';

class DistricListController extends StateNotifier<AsyncValue<List<District>>> {
  final ProfileRepository profileRepository;
  final String id;
  DistricListController({required this.profileRepository, required this.id})
      : super(const AsyncValue.loading()) {
    districtListC();
  }

  districtListC() async {
    final result = await profileRepository.getDistrictListRepo(id);
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final districListControllerProvider = StateNotifierProvider.family
    .autoDispose<DistricListController, AsyncValue<List<District>>, String>(
        (ref, id) {
  return DistricListController(
      profileRepository: ref.read(
        profileRepositoryProvider,
      ),
      id: id);
});
