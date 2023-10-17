import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_exception/api_exception.dart';
import 'package:nelta/core/app_error.dart';
import 'package:nelta/features/auth/data/data_source/token_data_source.dart';
import 'package:nelta/features/auth/data/models/token_model/token_request_model.dart';
import 'package:nelta/features/auth/data/models/token_model/token_response_model.dart';

abstract class TokenRepository {
  Future<Either<AppError, TokenResponseModel>> requestTokenRepo(
      TokenRequestModel tokenRequestModel);
}

class TokenRepositoryImp implements TokenRepository {
  final TokenDataSource tokenDataSource;
  TokenRepositoryImp(this.tokenDataSource);
  @override
  Future<Either<AppError, TokenResponseModel>> requestTokenRepo(
      TokenRequestModel tokenRequestModel) async {
    try {
      final result = await tokenDataSource.tokenRequestDs(tokenRequestModel);
      log(result.toString());
      return Right(result);
    } on DioException catch (e) {
      return Left(AppError(e.message!));
    }
  }
}

final tokenRepositoryProvider = Provider<TokenRepository>((ref) {
  return TokenRepositoryImp(ref.read(tokenDataSourceProvider));
});
