import 'dart:async';
import 'package:alex_poker/app/home/presentation/bloc/user_profile_bloc.dart';
import 'package:alex_poker/core/notification/notification.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/services/app_router/app_router.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/usecases/get_account.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/signup.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final Signup signup;
  final Login login;
  final GetAccount getAccount;
  AuthenticationBloc({required this.signup, required this.login, required this.getAccount}) : super(AuthenticationInitial()) {
    on<AuthenticationEventSignup>(_onSignup);
    on<AuthenticationEventLogin>(_onLogin);
    on<AuthenticationEventReLogin>(_onReLogin);
  }

  FutureOr<void> _onSignup(AuthenticationEventSignup event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationStateLoading());
    Account account = event.account;
    var failure = await signup.call(account);
    if(failure == null) {
      emit(AuthenticationInitial());
      _getProfile();
    } else {
      AppNotification.showSnackBar(
          message: failure.message,
          notificationMode: NotificationMode.error
      );
      emit(AuthenticationStateSignUpFail(message: failure.message));
    }
  }

  FutureOr<void> _onLogin(AuthenticationEventLogin event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationStateLoading());
    var failure = await login.call(event.account);
    if(failure != null) {
      AppNotification.showSnackBar(
        message: failure.message,
        notificationMode: NotificationMode.error
      );
      emit(AuthenticationStateLoginFail(message: failure.message));
      AppRouter.pushReplacement(AppRoutes.login);
    } else {
      emit(const AuthenticationStateLoginSuccessful());
      _getProfile();
    }
  }


  FutureOr<void> _onReLogin(AuthenticationEventReLogin event, Emitter<AuthenticationState> emit) {
    _getProfile();
  }

  void _getProfile() {
    BlocProvider.of<UserProfileBloc>(AppRouter.navigatorKey.currentState!.context).add(const UserProfileEventGet());
  }
}
