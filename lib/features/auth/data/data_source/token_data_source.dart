import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_client/api_client.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/features/auth/data/models/token_model/token_request_model.dart';
import 'package:nelta/features/auth/data/models/token_model/token_response_model.dart';

abstract class TokenDataSource {
  Future<TokenResponseModel> tokenRequestDs(
      TokenRequestModel tokenRequestModel);
}

class TokenDatSourceImpl implements TokenDataSource {
  final ApiClient apiClient;
  TokenDatSourceImpl(this.apiClient);
  @override
  Future<TokenResponseModel> tokenRequestDs(
      TokenRequestModel tokenRequestModel) async {
    final result = await apiClient.request(
        path: ApiConst.apiGettoken,
        type: "post",
        data: tokenRequestModel.toMap());

    return TokenResponseModel.fromMap(result);
  }
}

final tokenDataSourceProvider = Provider<TokenDataSource>((ref) {
  return TokenDatSourceImpl(ref.read(apiClientProvider));
});
