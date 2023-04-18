part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationEventSignup extends AuthenticationEvent {
  const AuthenticationEventSignup({required this.account});
  final Account account;
  @override
  List<Object?> get props => [account];
}

class AuthenticationEventLogin extends AuthenticationEvent {
  const AuthenticationEventLogin({required this.account});
  final Account account;

  @override
  List<Object?> get props => [account];
}

class AuthenticationEventReLogin extends AuthenticationEvent {
  const AuthenticationEventReLogin();

  @override
  List<Object?> get props => [];
}