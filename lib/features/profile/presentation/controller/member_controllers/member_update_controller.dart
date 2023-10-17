import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/profile/data/model/member_models/member_profile_update_response_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

import '../../views/member/member_profile_screen.dart';

class UpdateMemberProfileController
    extends StateNotifier<AsyncValue<MemberProfileUpdateResponseModel>> {
  UpdateMemberProfileController(this.profileRepository)
      : super(const AsyncValue.loading());
  final ProfileRepository profileRepository;

  updateMemberProfileC2(
    FormData formData,
    BuildContext context,
  ) async {
    final result =
        await profileRepository.updateMemberProfileFormDataRepo(formData);

    return result.fold((l) {
      showCustomSnackBar(l.message, context, isError: true);
      state = AsyncValue.error(
        l,
        StackTrace.fromString(l.message),
      );
    }, (r) {
      state = AsyncValue.data(r);
      if (context.mounted) {
        // log(json.encode(r.toMap()));
        showCustomSnackBar(r.success, context, isError: false);

        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (ctx) => MemberProfilScreen()),
            (route) => route.isFirst);
        // normalNav(context, const ProfilScreen());
        // pushAndRemoveUntil(context, const Dashboard());
      }
    });
  }
}

final updatememberProfileControllerProvider2 = StateNotifierProvider<
    UpdateMemberProfileController,
    AsyncValue<MemberProfileUpdateResponseModel>>((ref) {
  return UpdateMemberProfileController(ref.read(profileRepositoryProvider));
});
