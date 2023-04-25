import 'dart:async';
import 'package:alex_poker/app/poker/presentation/bloc/page/page_cubit.dart';
import 'package:socket_io_client/socket_io_client.dart' as sk;

enum PokerAction {
  connected,
  disconnected,
  error,
  receiveLobbyInfo,
  fetchLobbyInfo,
  joinRoom,
  roomJoined,
  roomsUpdated,
  leaveRoom,
  roomLeft,
  fold,
  check,
  call,
  raise,
  roomMessage,
  sitDown,
  reBuy,
  standUp,
  sittingOut,
  sittingIn,
  disconnect,
  winner,
  roomUpdated
}

extension PokerActionExtension on PokerAction {
  String get toSocketEvent {
    switch(this) {
      case PokerAction.connected:
        return 'CONNECTED';
      case PokerAction.disconnected:
        return 'DISCONNECTED';
      case PokerAction.error:
        return 'ERROR';
      case PokerAction.receiveLobbyInfo:
        return 'RECEIVE_LOBBY_INFO';
      case PokerAction.fetchLobbyInfo:
        return 'FETCH_LOBBY_INFO';
      case PokerAction.joinRoom:
        return 'JOIN_TABLE';
      case PokerAction.roomJoined:
        return 'TABLE_JOINED';
      case PokerAction.roomsUpdated:
        return 'TABLES_UPDATED';
      case PokerAction.leaveRoom:
        return 'LEAVE_TABLE';
      case PokerAction.roomLeft:
        return 'TABLE_LEFT';
      case PokerAction.fold:
        return 'FOLD';
      case PokerAction.check:
        return 'CHECK';
      case PokerAction.call:
        return 'CALL';
      case PokerAction.raise:
        return 'RAISE';
      case PokerAction.roomMessage:
        return 'TABLE_MESSAGE';
      case PokerAction.sitDown:
        return 'SIT_DOWN';
      case PokerAction.reBuy:
        return 'REBUY';
      case PokerAction.standUp:
        return 'STAND_UP';
      case PokerAction.sittingOut:
        return 'SITTING_OUT';
      case PokerAction.sittingIn:
        return 'SITTING_IN';
      case PokerAction.disconnect:
        return 'DISCONNECT';
      case PokerAction.winner:
        return 'WINNER';
      case PokerAction.roomUpdated:
        return "TABLE_UPDATED";
    }
  }
}

class PokerMessage {
  const PokerMessage({required this.pokerAction, required this.data});
  final PokerAction pokerAction;
  final dynamic data;
}

class PokerSocket {
  PokerSocket._();
  static PokerSocket? _instance;

  static PokerSocket get instance {
    _instance ??= PokerSocket._();
    return _instance!;
  }

  late sk.Socket _socket;
  final StreamController<PokerMessage> _streamController = StreamController<PokerMessage>.broadcast();

  void connect(String ip, String token) {
    _socket = sk.io('https://$ip/',
        sk.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build()
    ).connect();
    _socket.onConnect((data) {
      _streamController.sink.add(const PokerMessage(
          pokerAction: PokerAction.connected,
          data: 'Connect Successful'
      ));
    });
    _socket.onDisconnect((data) {
      _streamController.sink.add(const PokerMessage(
          pokerAction: PokerAction.disconnected,
          data: 'Disconnected'
      ));
    });
    _socket.onError((data) {
      _streamController.sink.add(PokerMessage(
          pokerAction: PokerAction.error,
          data: data
      ));
    });
    _socket.on(PokerAction.receiveLobbyInfo.toSocketEvent, (data) {
      _streamController.sink.add(
        PokerMessage(
            pokerAction: PokerAction.receiveLobbyInfo,
            data: data
        )
      );
    });
    _socket.on(PokerAction.roomJoined.toSocketEvent, (data) {
      _streamController.sink.add(
          PokerMessage(
              pokerAction: PokerAction.roomJoined,
              data: data
          )
      );
    });
    _socket.on(PokerAction.roomsUpdated.toSocketEvent, (data) {
      _streamController.sink.add(
          PokerMessage(
              pokerAction: PokerAction.receiveLobbyInfo,
              data: data
          )
      );
    });
    _socket.on(PokerAction.roomUpdated.toSocketEvent, (data) {
      _streamController.sink.add(
        PokerMessage(
          pokerAction: PokerAction.roomUpdated,
          data: data
        )
      );
    });
  }

  void emit(PokerAction event, Map<String, dynamic> data) {
    _socket.emit(event.toSocketEvent, data);
  }

  Stream<PokerMessage> get stream => _streamController.stream;
}