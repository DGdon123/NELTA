import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/conference/data/model/branch_model.dart';
import 'package:nelta/features/conference/data/repositories/conference_repository.dart';

class BranchListController
    extends StateNotifier<AsyncValue<List<BranchModel>>> {
  final ConferenceRepository conferenceRepository;
  BranchListController({required this.conferenceRepository})
      : super(const AsyncValue.loading()) {
    getBranchList();
  }

  getBranchList() async {
    final result = await conferenceRepository.getBranchListRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final branchListControllerProvider =
    StateNotifierProvider<BranchListController, AsyncValue<List<BranchModel>>>(
        (ref) {
  return BranchListController(
      conferenceRepository: ref.read(conferenceListRepoProvider));
});
