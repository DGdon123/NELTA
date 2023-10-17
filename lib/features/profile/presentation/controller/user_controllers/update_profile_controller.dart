import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/profile/data/model/user_models/update_profile_response_model.dart';
import 'package:nelta/features/profile/data/repository/profile_repository.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

import '../../views/user/profile_screen.dart';

class UpdateProfilControllerNotifier
    extends StateNotifier<AsyncValue<ProfileUpdateResponseModel>> {
  UpdateProfilControllerNotifier(this.profileRepository)
      : super(const AsyncValue.loading());
  final ProfileRepository profileRepository;

  updateProfileC(
    FormData formData,
    BuildContext context,
  ) async {
    final result = await profileRepository.updateUserProfileRepo(formData);

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
        showCustomSnackBar("Profile Updated Successfully", context,
            isError: false);
        // normalNav(context, const ProfilScreen());
        // pushAndRemoveUntil(context, const Dashboard());

        Navigator.of(context).pushAndRemoveUntil(
            CupertinoPageRoute(builder: (ctx) => ProfilScreen()),
            (route) => route.isFirst);
      }
    });
  }
}

final updateProfileControllerProvider = StateNotifierProvider<
    UpdateProfilControllerNotifier,
    AsyncValue<ProfileUpdateResponseModel>>((ref) {
  return UpdateProfilControllerNotifier(ref.read(profileRepositoryProvider));
});
