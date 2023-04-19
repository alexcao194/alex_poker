import 'dart:async';

import 'package:alex_poker/core/services/app_router/app_router.dart';
import 'package:alex_poker/core/services/poker_socket/poker_socket.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/services/notification/notification.dart';
import '../../../domain/entities/room.dart';
import '../../../domain/usecases/connect.dart';
import '../../../domain/usecases/disconnect.dart';
import '../../../domain/usecases/fetch_lobby_info.dart';
import '../../../domain/usecases/join_room.dart';
import '../page/page_cubit.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final Connect connect;
  final Disconnect disconnect;
  final FetchLobbyInfo fetchLobbyInfo;
  final JoinRoom joinRoom;
  Stream<PokerMessage>? controller;
  RoomBloc({
    required this.connect,
    required this.disconnect,
    required this.fetchLobbyInfo,
    required this.joinRoom,
  }) : super(const RoomInitial()) {
    on<RoomEventConnect>(_onConnect);
    on<RoomEventDisConnect>(_onDisconnect);
    on<RoomEventGetRoom>(_onGet);
    on<RoomEventSendData>(_onSend);
    on<RoomEventSendError>(_onError);
    on<RoomEventJoin>(_onJoin);
  }

  FutureOr<void> _onConnect(RoomEventConnect event, Emitter<RoomState> emit) {
    if(controller == null) {
      controller = connect.call();
      controller!.listen((event) {
        // ignore: missing_enum_constant_in_switch
        switch(event.pokerAction) {
          case PokerAction.connected:
            add(const RoomEventGetRoom(roomPage: RoomPage.normal));
            AppRouter.push(AppRoutes.pokerRoom);
            break;
          case PokerAction.disconnected:
            AppRouter.pushAndRemoveUntil(AppRoutes.home, AppRoutes.entry);
            break;
          case PokerAction.error:
            add(RoomEventSendData(data: event.data));
            break;
          case PokerAction.receiveLobbyInfo:
            add(RoomEventSendData(data: event.data));
            break;
          case PokerAction.roomLeft:
            add(RoomEventSendData(data: event.data));
            break;
          case PokerAction.disconnect:
            AppRouter.pop();
            break;
        }
      });
    } else {
      connect.call();
    }
  }

  FutureOr<void> _onDisconnect(RoomEventDisConnect event, Emitter<RoomState> emit) {
    disconnect.call();
  }

  FutureOr<void> _onGet(RoomEventGetRoom event, Emitter<RoomState> emit) {
    emit(const RoomStateLoading());
    fetchLobbyInfo.call(event.roomPage.index);
  }

  FutureOr<void> _onSend(RoomEventSendData event, Emitter<RoomState> emit) {
    emit(RoomStateGetSuccessful(
        listRoom: event.data
    ));
  }

  FutureOr<void> _onError(RoomEventSendError event, Emitter<RoomState> emit) {
    AppNotification.showSnackBar(
        message: event.message,
        notificationMode: NotificationMode.error
    );
    emit(RoomStateGetFail(error: event.message));
  }

  FutureOr<void> _onJoin(RoomEventJoin event, Emitter<RoomState> emit) {
    joinRoom.call(event.id);
  }
}
