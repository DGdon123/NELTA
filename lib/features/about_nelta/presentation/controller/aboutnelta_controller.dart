import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/about_nelta/data/model/about_nelta_model.dart';
import 'package:nelta/features/about_nelta/data/repository/aboutnelta_repository.dart';

class AboutNeltaController extends StateNotifier<AsyncValue<AboutNeltaModel>> {
  final AboutNeltaRepository aboutNeltaRepository;
  AboutNeltaController({required this.aboutNeltaRepository})
      : super(const AsyncValue.loading()) {
    getAboutNelta();
  }

  getAboutNelta() async {
    final result = await aboutNeltaRepository.getAboutNeltaRepo();
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final aboutNeltaControllerProvider =
    StateNotifierProvider<AboutNeltaController, AsyncValue<AboutNeltaModel>>(
        (ref) {
  return AboutNeltaController(
      aboutNeltaRepository: ref.read(aboutNeltaRepositoryController));
});
