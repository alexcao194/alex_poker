import 'package:alex_poker/core/services/poker_socket/poker_socket.dart';

abstract class Repositories {
  const Repositories();

  Stream<PokerMessage> connect();
  void disconnect();
  void fetchLobbyInfo(int type);
  void joinRoom(String id);
  void leaveRoom(String id);
  void sitDown(String tableId, int seatId, int amount);
}