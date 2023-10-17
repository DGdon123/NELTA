import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/profile/data/model/member_models/member_profile_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';

class MemberProfileController
    extends StateNotifier<AsyncValue<MemberProfileResponseModel>> {
  final ProfileRepository profileRepository;

  MemberProfileController({
    required this.profileRepository,
  }) : super(const AsyncValue.loading()) {
    getUserProfileC();
  }
  getUserProfileC() async {
    final result = await profileRepository.getMemberProfileRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) async {
      await DbClient().setData(dbKey: "memberData", value: r.toJson());
      return state = AsyncValue.data(r);
    });
  }
}

final getmemberProfileControllerProvider = StateNotifierProvider.autoDispose<
    MemberProfileController, AsyncValue<MemberProfileResponseModel>>((
  ref,
) {
  return MemberProfileController(
      profileRepository: ref.read(profileRepositoryProvider));
});
