import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/about_nelta/data/model/about_nelta_model.dart';

abstract class AboutNeltaDataSource {
  Future<AboutNeltaModel> getAboutNeltaDS();
}

class AboutNeltaDataSourceimpl implements AboutNeltaDataSource {
  final ApiClient apiClient;
  AboutNeltaDataSourceimpl(this.apiClient);

  @override
  Future<AboutNeltaModel> getAboutNeltaDS() async {
    final result = await apiClient.request(path: ApiConst.about);
    return AboutNeltaModel.fromJson(result["about"]);
  }
}

final aboutNeltaDataSourceProvider = Provider<AboutNeltaDataSource>((ref) {
  return AboutNeltaDataSourceimpl(ref.read(apiClientProvider));
});
