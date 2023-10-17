import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/resources/data/model/resources_model.dart';

import '../model/resouces_down_model.dart';

abstract class ResoucesDataSource {
  Future<List<ResoucesModel>> getResourcesDS();
  Future<List<ResourceDownloadModel>> getResourcesDetailDS(String id);
}

class ResoucesDataSourceimpl implements ResoucesDataSource {
  final ApiClient apiClient;
  ResoucesDataSourceimpl(this.apiClient);

  @override
  Future<List<ResoucesModel>> getResourcesDS() async {
    final String lifeMember = await DbClient().getData(dbKey: "lifeMember");
    String endpointResource = lifeMember == "true" ? "y" : "n";
    log(endpointResource);
    final result = await apiClient.request(
        path: "${ApiConst.eduresources}/?is_member=$endpointResource");
    List data = result["eduresources"];
    return data.map((e) => ResoucesModel.fromMap(e)).toList();
  }

  Future<List<ResourceDownloadModel>> getResourcesDetailDS(String id) async {
    final result = await apiClient.request(path: ApiConst.eduresourceID + id);
    List data = result["eduresource"];
    // log(data.toString());
    return data.map((e) => ResourceDownloadModel.fromMap(e)).toList();
  }
  // @override
  // Future<ResoucesModel> getResourcesDetailDS(String id) async {
  //   final result = await apiClient.request(path: ApiConst.eduresourceID + id);
  //   // log(result);
  //   return ResoucesModel.fromMap(result["eduresource"]);
  // }
}

final resoucesDataSourceProvider = Provider<ResoucesDataSource>((ref) {
  return ResoucesDataSourceimpl(ref.read(apiClientProvider));
});
