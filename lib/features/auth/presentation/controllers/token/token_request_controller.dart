import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nelta/core/api_const/db_client.dart';
import 'package:nelta/features/auth/data/models/token_model/token_request_model.dart';
import 'package:nelta/features/auth/data/repositories/token_repository.dart';
import 'package:nelta/features/auth/presentation/controllers/token/token_state.dart';
import 'package:nelta/features/auth/presentation/login/login_screen.dart';
import 'package:nelta/utils/custom_navigation/app_nav.dart';
import 'package:nelta/utils/snackbar/custome_snack_bar.dart';

class AuthControllerNotifier extends StateNotifier<AuthState> {
  AuthControllerNotifier(
      {required this.tokenRepository, required this.dbClient})
      : super(const AuthState.loading()) {
    checkToken();
  }
  final TokenRepository tokenRepository;
  final DbClient dbClient;

  checkToken() async {
    final String dbResult = await dbClient.getData(dbKey: "token");
    return dbResult.isEmpty
        ? state = const AuthState.loggedOut()
        : state = const AuthState.loggedIn();
  }

  reqesestToken(
      TokenRequestModel tokenRequestModel, BuildContext contex) async {
    final result = await tokenRepository.requestTokenRepo(tokenRequestModel);

    return result.fold(
        (l) => showCustomSnackBar(
              l.message,
              contex,
            ),
        (r) => r.token);
  }

  logout(BuildContext context) async {
    await DbClient().removeData(dbKey: "userData");
    await DbClient().removeData(dbKey: "lifeMember");
    await dbClient.reset();
    state = const AuthState.loggedOut();
    if (!mounted) return;
    pushAndRemoveUntil(context, const LoginScreen());
    showCustomSnackBar("Logout Successfully", context, isError: false);
  }
}

final tokenControllerProvider =
    StateNotifierProvider<AuthControllerNotifier, AuthState>((ref) {
  return AuthControllerNotifier(
      tokenRepository: ref.read(tokenRepositoryProvider),
      dbClient: ref.read(dbClientProvider));
});
