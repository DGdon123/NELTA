import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_const/api_const.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/core/api_exception/api_exception.dart';

class ApiClient {
  final DbClient _dbClient;
  ApiClient(this._dbClient);
  Future request(
      {required String path,
      String type = "get",
      Map<String, dynamic> data = const {},
      String token = ""}) async {
    final String dbResult =
        token.isEmpty ? await _dbClient.getData(dbKey: "token") : token;
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseURl,
        headers: {
          'Content-Type': 'application/json',
          "Accept": 'application/json',
          "Authorization": "Bearer $dbResult"
        },
      ),
    );
    try {
      final result = type == "get"
          ? await dio.get(path)
          : await dio.post(path, data: data);
      return result.data;
    } on DioError catch (e) {
      // log(e.error.);
      log(e.response!.statusCode.toString());
      log(e.response!.toString());
      log(e.error.toString());
      log(e.message!.toString());
      // log(e.type.toString());
      throw DioException.fromDioError(e);
    }
  }

  Future requestFormData(
      {required String path,
      required FormData formData,
      String token = ""}) async {
    final String dbResult =
        token.isEmpty ? await _dbClient.getData(dbKey: "token") : token;
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseURl,
        headers: {
          'Content-Type': 'application/json',
          "Accept": 'application/json',
          "Authorization": "Bearer $dbResult"
        },
      ),
    );
    try {
      final result = await dio.post(path, data: formData);
      return result.data;
    } on DioError catch (e) {
      throw DioException.fromDioError(e);
    }
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(ref.read(dbClientProvider));
});
