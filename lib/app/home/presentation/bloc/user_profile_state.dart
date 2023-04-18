part of 'user_profile_bloc.dart';

abstract class UserProfileState extends Equatable {
  const UserProfileState();
}

class UserProfileInitial extends UserProfileState {
  @override
  List<Object> get props => [];
}

class UserProfileStateLoading extends UserProfileState {
  const UserProfileStateLoading();

  @override
  List<Object?> get props => [];
}

class UserProfileStateGetSuccessful extends UserProfileState {
  const UserProfileStateGetSuccessful({required this.user});

  final User user;

  @override
  List<Object?> get props => [user];
}

class UserProfileStateGetFail extends UserProfileState {
  const UserProfileStateGetFail({required this.message});
  final String message;

  @override
  List<Object?> get props => [message];
}