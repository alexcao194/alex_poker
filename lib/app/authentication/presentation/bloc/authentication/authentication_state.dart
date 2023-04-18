part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationStateLoading extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateSignUpFail extends AuthenticationState {
  const AuthenticationStateSignUpFail({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class AuthenticationStateLoginFail extends AuthenticationState {
  const AuthenticationStateLoginFail({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}

class AuthenticationStateLoginSuccessful extends AuthenticationState {
  const AuthenticationStateLoginSuccessful();

  @override
  List<Object?> get props => [];
}