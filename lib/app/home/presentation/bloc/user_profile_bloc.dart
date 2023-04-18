import 'dart:async';

import 'package:alex_poker/app/home/domain/entities/user.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/notification/notification.dart';
import '../../../../core/services/app_router/app_router.dart';
import '../../domain/usecases/get_profile.dart';

part 'user_profile_event.dart';
part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  final GetProfile getProfile;
  UserProfileBloc({required this.getProfile}) : super(UserProfileInitial()) {
    on<UserProfileEventGet>(_onGet);
    on<UserProfileEventUpdate>(_onUpdate);
  }

  FutureOr<void> _onGet(UserProfileEventGet event, Emitter<UserProfileState> emit) async {
    var result = await getProfile.call();
    result.fold(
      (failure) {
        AppNotification.showSnackBar(
            message: failure.message,
            notificationMode: NotificationMode.error
        );
        AppRouter.pushAndRemoveUntil(AppRoutes.login, AppRoutes.entry);
      },
      (user) {
        emit(UserProfileStateGetSuccessful(user: user));
        AppRouter.pushAndRemoveUntil(AppRoutes.home, AppRoutes.entry);
      }
    );
  }

  FutureOr<void> _onUpdate(UserProfileEventUpdate event, Emitter<UserProfileState> emit) async {
    throw UnimplementedError();
  }
}
