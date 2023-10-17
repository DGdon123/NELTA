import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nelta/features/profile/data/model/location_model/getdistrict_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';

class DistrictController extends StateNotifier<AsyncValue<District>> {
  final ProfileRepository profileRepository;
  DistrictController({
    required this.profileRepository,
  }) : super(const AsyncValue.loading()) {
    getDistrictC();
  }
  getDistrictC() async {
    final result = await profileRepository.getDistrictRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final districtController =
    StateNotifierProvider<DistrictController, AsyncValue<District>>((ref) {
  return DistrictController(
      profileRepository: ref.read(profileRepositoryProvider));
});
