import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/activity/data/models/activity_model.dart';
import 'package:nelta/features/activity/data/repositories/activity_repository.dart';

class AcitivityController
    extends StateNotifier<AsyncValue<List<ActivityModel>>> {
  final ActivityRepositories activityRepositories;
  AcitivityController({required this.activityRepositories})
      : super(const AsyncValue.loading()) {
    getNoticesList();
  }

  getNoticesList() async {
    final result = await activityRepositories.getActivityRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final acitivityControllerProvider =
    StateNotifierProvider<AcitivityController, AsyncValue<List<ActivityModel>>>(
        (ref) {
  return AcitivityController(
      activityRepositories: ref.read(activityRepositoriesController));
});
