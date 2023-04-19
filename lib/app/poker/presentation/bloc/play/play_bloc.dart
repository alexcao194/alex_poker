import 'dart:async';

import 'package:alex_poker/app/poker/domain/entities/room.dart';
import 'package:alex_poker/app/poker/domain/usecases/sit_down.dart';
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
  final SitDown sitDown;
  Stream<PokerMessage>? controller;
  PlayBloc({
    required this.leaveRoom,
    required this.connect,
    required this.sitDown
}) : super(PlayInitial()) {
    on<PlayEventConnect>(_onConnect);
    on<PlayEventLeave>(_onLeave);
    on<PlayEventSendData>(_onSend);
    on<PlayEventSendError>(_onSendError);
    on<PlayEventSitDown>(_onSitDown);
  }

  FutureOr<void> _onConnect(PlayEventConnect event, Emitter<PlayState> emit) {
    if(controller == null) {
      controller = connect.call();
      controller!.listen((event) {
        // ignore: missing_enum_constant_in_switch
        switch(event.pokerAction) {
          case PokerAction.roomJoined:
            add(PlayEventSendData(data: event.data));
            AppRouter.push(AppRoutes.play);
            break;
          case PokerAction.roomUpdated:
            add(PlayEventSendData(data: event.data));
        }
      });
    } else {
      connect.call();
    }
  }

  FutureOr<void> _onLeave(PlayEventLeave event, Emitter<PlayState> emit) {
    leaveRoom.call(event.roomId);
  }

  FutureOr<void> _onSendError(PlayEventSendError event, Emitter<PlayState> emit) {

  }

  FutureOr<void> _onSend(PlayEventSendData event, Emitter<PlayState> emit) {
    emit(PlayStatePlaying(room: event.data));
  }

  FutureOr<void> _onSitDown(PlayEventSitDown event, Emitter<PlayState> emit) {
    sitDown.call(event.tableId, event.seatId, event.amount);
  }
}
