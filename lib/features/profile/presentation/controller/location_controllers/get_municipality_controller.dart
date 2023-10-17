import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:nelta/features/profile/data/model/location_model/getmuni_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';

class MunicipalityController
    extends StateNotifier<AsyncValue<MunicipalityModel>> {
  final ProfileRepository profileRepository;
  MunicipalityController({
    required this.profileRepository,
  }) : super(const AsyncValue.loading()) {
    getMunicipality();
  }
  getMunicipality() async {
    final result = await profileRepository.getMunicpalityRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final municipalityControllerProvider = StateNotifierProvider<
    MunicipalityController, AsyncValue<MunicipalityModel>>((ref) {
  return MunicipalityController(
      profileRepository: ref.read(profileRepositoryProvider));
});
