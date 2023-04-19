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
  final Map<int ,Seat?> seats;
  final List<Card> board;
  final int button;
  final int turn;
  final int pot;
  final int mainPot;
  final int callAmount;
  final int minBet;
  final int minRaise;
  final bool handOver;
  final List<String> winMessage;
  final List<Object> sidePots;
  final String message;


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
    this.button = 0,
    this.callAmount = 0,
    this.handOver = true,
    this.mainPot = 0,
    this.pot = 0,
    this.players = const [],
    this.seats = const {
      1 : null,
      2 : null,
      3 : null,
      4 : null,
      5 : null
    },
    this.turn = 0,
    this.sidePots = const [],
    this.winMessage = const [],
    this.minBet = 0,
    this.minRaise = 0,
    this.message = ''
  }) : assert(seats.length == 5);
}