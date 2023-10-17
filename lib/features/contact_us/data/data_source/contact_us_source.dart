import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/contact_us/data/model/contactus_model.dart';

abstract class ContactUsModelDataSource {
  Future<ContactUsModel> getContactUsDS();
}

class ContactUsModelDataSourceimpl implements ContactUsModelDataSource {
  final ApiClient apiClient;
  ContactUsModelDataSourceimpl(this.apiClient);

  @override
  Future<ContactUsModel> getContactUsDS() async {
    final result = await apiClient.request(path: ApiConst.office);
    return ContactUsModel.fromJson(result["office"]);
  }
}

final contactUsModelDataSourceProvider = Provider<ContactUsModelDataSource>((ref) {
  return ContactUsModelDataSourceimpl(ref.read(apiClientProvider));
});
