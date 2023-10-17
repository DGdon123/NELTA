import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/features/auth/data/models/countries_list_model.dart';
import '../../../data/repositories/auth_repository.dart';

class CountriesListController
    extends StateNotifier<AsyncValue<List<CountryModel>>> {
  final AuthRepositories authRepositories;
  CountriesListController({required this.authRepositories})
      : super(const AsyncValue.loading()) {
    // getCountries();
    // getCountries(String token)
  }

  getCountries(String token) async {
    final result = await authRepositories.getCountriesListRepo(token);
    return result.fold(
        (l) => state =
            AsyncValue.error(l.message, StackTrace.fromString(l.message)),
        (r) => state = AsyncValue.data(r));
  }
}

final countriesListControllerProvider = StateNotifierProvider<
    CountriesListController, AsyncValue<List<CountryModel>>>((ref) {
  return CountriesListController(
      authRepositories: ref.read(authRepositoriesProvider));
});
