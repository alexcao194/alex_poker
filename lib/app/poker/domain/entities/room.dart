import 'player.dart';
import 'seat.dart';

class Room {
  final String id;
  final String name;
  final int limit;
  final int maxPlayers;
  final int currentNumberPlayers;
  final int smallBlind;
  final int bigBlind;
  final int type;
  // final List<Player> players;
  // final List<Seat> seats;


  Room({
    required this.id,
    required this.name,
    required this.limit,
    required this.maxPlayers,
    required this.currentNumberPlayers,
    required this.smallBlind,
    required this.bigBlind,
    required this.type
  });
}