part of 'user_profile_bloc.dart';

abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();
}

class UserProfileEventGet extends UserProfileEvent {
  const UserProfileEventGet();
  @override
  List<Object?> get props => [];
}

class UserProfileEventUpdate extends UserProfileEvent {
  const UserProfileEventUpdate();

  @override
  List<Object?> get props => [];
}