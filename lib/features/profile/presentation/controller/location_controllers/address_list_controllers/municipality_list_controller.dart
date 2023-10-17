import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/profile/data/model/location_model/getmuni_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';

class MunicipalityListController
    extends StateNotifier<AsyncValue<List<MunicipalityModel>>> {
  final ProfileRepository profileRepository;
  final String id;
  MunicipalityListController(
      {required this.profileRepository, required this.id})
      : super(const AsyncValue.loading()) {
    municipalityList();
  }

  municipalityList() async {
    final result = await profileRepository.getMunicipalityListRepo(id);
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final municipalityListControllerProvider = StateNotifierProvider.family
    .autoDispose<MunicipalityListController,
        AsyncValue<List<MunicipalityModel>>, String>((ref, id) {
  return MunicipalityListController(
      profileRepository: ref.read(
        profileRepositoryProvider,
      ),
      id: id);
});
