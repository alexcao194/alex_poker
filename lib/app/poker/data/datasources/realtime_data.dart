import 'dart:async';

import 'package:alex_poker/app/poker/data/models/room.dart';

import '../../../../core/services/poker_socket/poker_socket.dart';


abstract class RealtimeData {
  const RealtimeData();

  Stream<PokerMessage> connect({required String ip, required String token});
  void disconnect();
  void fetchLobbyInfo(int type, String token);
  void joinRoom(String id);
  void leaveRoom(String id);
}

class RealtimeDataImpl extends RealtimeData {
  StreamController<PokerMessage> streamController = StreamController();
  Stream<PokerMessage>? streamFromSocket;
  @override
  Stream<PokerMessage> connect({required String ip, required String token}) {
    var pokerSocket = PokerSocket.instance;
    pokerSocket.connect(ip, token);
    if(streamFromSocket == null) {
      streamFromSocket = pokerSocket.stream;
      streamFromSocket!.listen((event) {
        var action = event.pokerAction;
        switch (action) {
          case PokerAction.connected:
            streamController.sink.add(event);
            break;
          case PokerAction.disconnected:
            streamController.sink.add(event);
            break;
          case PokerAction.error:
            streamController.sink.add(event);
            break;
          case PokerAction.receiveLobbyInfo:
            var data = event.data['tables'];
            List<RoomModel> listRoom = [];
            for (var room in data) {
              listRoom.add(RoomModel.fromJson(room));
            }
            streamController.sink.add(
              PokerMessage(
                pokerAction: action,
                data: listRoom
              )
            );
            break;
          case PokerAction.fetchLobbyInfo:
            break;
          case PokerAction.joinRoom:
            break;
          case PokerAction.roomJoined:
            print(event.data);
            streamController.sink.add(
                PokerMessage(
                    pokerAction: action,
                    data: RoomModel.fromJson(event.data['table'])
                )
            );
            break;
          case PokerAction.roomUpdated:
            break;
          case PokerAction.leaveRoom:
            // TODO: Handle this case.
            break;
          case PokerAction.roomLeft:
            // TODO: Handle this case.
            break;
          case PokerAction.fold:
            // TODO: Handle this case.
            break;
          case PokerAction.check:
            // TODO: Handle this case.
            break;
          case PokerAction.call:
            // TODO: Handle this case.
            break;
          case PokerAction.raise:
            // TODO: Handle this case.
            break;
          case PokerAction.roomMessage:
            // TODO: Handle this case.
            break;
          case PokerAction.sitDown:
            // TODO: Handle this case.
            break;
          case PokerAction.reBuy:
            // TODO: Handle this case.
            break;
          case PokerAction.standUp:
            // TODO: Handle this case.
            break;
          case PokerAction.sittingOut:
            // TODO: Handle this case.
            break;
          case PokerAction.sittingIn:
            // TODO: Handle this case.
            break;
          case PokerAction.disconnect:
            // TODO: Handle this case.
            break;
          case PokerAction.winner:
            // TODO: Handle this case.
            break;
        }
      });
    }
    return streamController.stream;
  }

  @override
  void disconnect() {
    PokerSocket.instance.emit(PokerAction.disconnect, {});
  }

  @override
  void fetchLobbyInfo(int type, String token) {
    PokerSocket.instance.emit(PokerAction.fetchLobbyInfo, {
      "token" : token,
      "type" : type
    });
  }

  @override
  void joinRoom(String id) {
    PokerSocket.instance.emit(PokerAction.joinRoom, {
      "tableId" : id
    });
  }

  @override
  void leaveRoom(String id) {
    PokerSocket.instance.emit(PokerAction.leaveRoom, {
      "tableId" : id
    });
  }
}