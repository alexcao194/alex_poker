import 'card.dart';
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
  final List<Player> players;
  final List<Seat> seats;
  final List<Card> board;
  final Object deck;
  final Object button;
  final Object turn;
  final int pot;
  final int mainPot;
  final Object callAmount;
  final int minBet;
  final int minRaise;
  final bool handOver;
  final List<String> winMessage;
  final List<Object> sidePots;
  final List<Object> history;


  Room({
    required this.id,
    required this.name,
    required this.limit,
    required this.maxPlayers,
    required this.currentNumberPlayers,
    required this.smallBlind,
    required this.bigBlind,
    required this.type,
    this.board = const [],
    this.button = const Object(),
    this.callAmount = const Object(),
    this.deck = const Object(),
    this.handOver = true,
    this.history = const [],
    this.mainPot = 0,
    this.pot = 0,
    this.players = const [],
    this.seats = const [],
    this.turn = const Object(),
    this.sidePots = const [],
    this.winMessage = const [],
    this.minBet = 0,
    this.minRaise = 0
  });
}