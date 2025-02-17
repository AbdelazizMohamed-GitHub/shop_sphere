class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}
class AuthVerifiy extends AuthState {
  final String message;

  AuthVerifiy(this.message);
}


class AuthError extends AuthState {
  final String errMessage;

  AuthError(this.errMessage);
}