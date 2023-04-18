import 'dart:async';

import 'package:alex_poker/app/poker/domain/entities/room.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/services/app_router/app_router.dart';
import '../../../../../core/services/poker_socket/poker_socket.dart';
import '../../../domain/usecases/connect.dart';
import '../../../domain/usecases/leave_room.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  final LeaveRoom leaveRoom;
  final Connect connect;
  Stream<PokerMessage>? controller;
  PlayBloc({
    required this.leaveRoom,
    required this.connect
}) : super(PlayInitial()) {
    on<PlayEventConnect>(_onConnect);
  }

  FutureOr<void> _onConnect(PlayEventConnect event, Emitter<PlayState> emit) {
    if(controller == null) {
      controller = connect.call();
      controller!.listen((event) {
        // ignore: missing_enum_constant_in_switch
        switch(event.pokerAction) {
          case PokerAction.roomJoined:
            AppRouter.push(AppRoutes.play);
            emit(PlayStatePlaying(room: event.data));
            break;
        }
      });
    } else {
      connect.call();
    }
  }
}
