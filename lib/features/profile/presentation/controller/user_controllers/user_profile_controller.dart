import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/profile/data/model/user_models/profile_response_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';

class UserProfielController
    extends StateNotifier<AsyncValue<ProfileResponseModel>> {
  final ProfileRepository profileRepository;
   UserProfielController({required this.profileRepository, })
      : super(const AsyncValue.loading()) {
    getUserProfileC();
  }
  getUserProfileC() async {
    final result = await profileRepository.getUserProfileRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final userProfileControllerProvider = StateNotifierProvider<
    UserProfielController, AsyncValue<ProfileResponseModel> >((ref) {
  return UserProfielController(
profileRepository: ref.read(profileRepositoryProvider));
});
