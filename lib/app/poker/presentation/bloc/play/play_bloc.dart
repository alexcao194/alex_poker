import 'dart:async';

import 'package:alex_poker/app/poker/domain/entities/room.dart';
import 'package:alex_poker/app/poker/domain/usecases/call.dart';
import 'package:alex_poker/app/poker/domain/usecases/sit_down.dart';
import 'package:alex_poker/app/poker/domain/usecases/stand_up.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/services/app_router/app_router.dart';
import '../../../../../core/services/poker_socket/poker_socket.dart';
import '../../../domain/usecases/check.dart';
import '../../../domain/usecases/connect.dart';
import '../../../domain/usecases/fold.dart';
import '../../../domain/usecases/leave_room.dart';
import '../../../domain/usecases/raise.dart';

part 'play_event.dart';
part 'play_state.dart';

class PlayBloc extends Bloc<PlayEvent, PlayState> {
  final LeaveRoom leaveRoom;
  final Connect connect;
  final SitDown sitDown;
  final Call call;
  final Check check;
  final Raise raise;
  final Fold fold;
  final StandUp standUp;
  Stream<PokerMessage>? controller;
  PlayBloc({
    required this.leaveRoom,
    required this.connect,
    required this.sitDown,
    required this.fold,
    required this.raise,
    required this.check,
    required this.call,
    required this.standUp
}) : super(PlayInitial()) {
    on<PlayEventConnect>(_onConnect);
    on<PlayEventLeave>(_onLeave);
    on<PlayEventSendData>(_onSend);
    on<PlayEventSendError>(_onSendError);
    on<PlayEventSitDown>(_onSitDown);
    on<PlayEventCall>(_onCall);
    on<PlayEventCheck>(_onCheck);
    on<PlayEventFold>(_onFold);
    on<PlayEventRaise>(_onRaise);
    on<PlayEventStandUp>(_onStandUp);
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
    sitDown.call(event.roomId, event.seatId, event.amount);
  }

  FutureOr<void> _onRaise(PlayEventRaise event, Emitter<PlayState> emit) {
    raise.call(event.roomId, event.amount);
  }

  FutureOr<void> _onFold(PlayEventFold event, Emitter<PlayState> emit) {
    fold.call(event.roomId);
  }

  FutureOr<void> _onCheck(PlayEventCheck event, Emitter<PlayState> emit) {
    check.call(event.roomId);
  }

  FutureOr<void> _onCall(PlayEventCall event, Emitter<PlayState> emit) {
    call.call(event.roomId);
  }

  FutureOr<void> _onStandUp(PlayEventStandUp event, Emitter<PlayState> emit) {
    standUp.call(event.roomId);
  }
}
