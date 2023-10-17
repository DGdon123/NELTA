// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:nelta/dashboard.dart';
// import 'package:nelta/features/profile/data/model/member_models/member_profile_update_response_model.dart';
// import 'package:nelta/features/profile/data/model/member_models/member_update_request_model.dart';
// import 'package:nelta/features/profile/data/repository/profile_repository.dart';
// import 'package:nelta/utils/custom_navigation/app_nav.dart';
// import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

// class UpdateMemberProfileController
//     extends StateNotifier<AsyncValue<MemberProfileUpdateResponseModel>> {
//   UpdateMemberProfileController(this.profileRepository)
//       : super(const AsyncValue.loading());
//   final ProfileRepository profileRepository;

//   updateMemberProfileC(
//     MemberUpdateRequestModel memberUpdateRequestModel,
//     BuildContext context,
//   ) async {
//     final result = await profileRepository
//         .updateMemberProfileRepo(memberUpdateRequestModel);

//     return result.fold((l) {
//       showCustomSnackBar(l.message, context, isError: true);
//       state = AsyncValue.error(
//         l,
//         StackTrace.fromString(l.message),
//       );
//     }, (r) {
//       state = AsyncValue.data(r);
//       if (context.mounted) {
//         // log(json.encode(r.toMap()));
//         showCustomSnackBar("Profile Updated Successfully", context,
//             isError: false);
//         // normalNav(context, const ProfilScreen());
//         pushAndRemoveUntil(context, const Dashboard());
//       }
//     });
//   }
// }

// final updatememberProfileControllerProvider = StateNotifierProvider<
//     UpdateMemberProfileController,
//     AsyncValue<MemberProfileUpdateResponseModel>>((ref) {
//   return UpdateMemberProfileController(ref.read(profileRepositoryProvider));
// });
