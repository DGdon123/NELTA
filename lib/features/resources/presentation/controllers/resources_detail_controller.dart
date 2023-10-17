import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/model/resouces_down_model.dart';
import '../../data/repository/resouces_repositories.dart';

class ResourcesDetailController
    extends StateNotifier<AsyncValue<List<ResourceDownloadModel>>> {
  final ResoucesRepositories resoucesRepositories;
  final String id;
  ResourcesDetailController(
      {required this.resoucesRepositories, required this.id})
      : super(const AsyncValue.loading()) {
    getSourcesDetail();
  }

  getSourcesDetail() async {
    final result = await resoucesRepositories.getResourcesDetailRepo(id);
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final resourcesDetailControllerProvider = StateNotifierProvider.family<
    ResourcesDetailController,
    AsyncValue<List<ResourceDownloadModel>>,
    String>((ref, id) {
  return ResourcesDetailController(
      resoucesRepositories: ref.read(
        resoucesRepositoriesProvider,
      ),
      id: id);
});
