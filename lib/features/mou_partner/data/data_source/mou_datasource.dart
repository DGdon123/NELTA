import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/mou_partner/data/model/mou_model.dart';

abstract class MouPartnerDataSource {
  Future<List<MouPartnerModel>> getMouPartnerDS();
}

class MouPartnerDataSourceimpl implements MouPartnerDataSource {
  final ApiClient apiClient;
  MouPartnerDataSourceimpl(this.apiClient);

  @override
  Future<List<MouPartnerModel>> getMouPartnerDS() async {
    final result = await apiClient.request(path: ApiConst.moupartners);
    List data = result["mou_partners"];
    return data.map((e) => MouPartnerModel.fromJson(e)).toList();
  }
}

final mouPartnerDataSourceProvider = Provider<MouPartnerDataSource>((ref) {
  return MouPartnerDataSourceimpl(ref.read(apiClientProvider));
});
