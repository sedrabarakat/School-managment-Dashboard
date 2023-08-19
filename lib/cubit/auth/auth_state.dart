part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class ChangePasswordVisibility extends AuthState {}

class AnimateTheButton extends AuthState {}

class OnHoverButton extends AuthState {}

class LoginLoadingState extends AuthState{}
class Success extends AuthState{}
class Error extends AuthState{}
class LoginSuccessState extends AuthState
{
  final LoginModel loginModel;

  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends AuthState {
  final LoginModel loginModel;

  LoginErrorState(this.loginModel);
}
