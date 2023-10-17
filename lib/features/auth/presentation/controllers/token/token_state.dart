import 'package:freezed_annotation/freezed_annotation.dart';
part 'token_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.loggedIn() = _LoggedIn;
  const factory AuthState.loggedOut() = _LoggedOut;
  const factory AuthState.loading() = _Loading;
}
