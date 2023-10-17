import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/model/resources_model.dart';
import '../../data/repository/resouces_repositories.dart';

class ResouresListController
    extends StateNotifier<AsyncValue<List<ResoucesModel>>> {
  final ResoucesRepositories resoucesRepositories;
  ResouresListController({required this.resoucesRepositories})
      : super(const AsyncValue.loading()) {
    getResoucesList();
  }

  getResoucesList() async {
    final result = await resoucesRepositories.getResourcesRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final resouresListController = StateNotifierProvider<ResouresListController,
    AsyncValue<List<ResoucesModel>>>((ref) {
  return ResouresListController(
      resoucesRepositories: ref.read(resoucesRepositoriesProvider));
});
