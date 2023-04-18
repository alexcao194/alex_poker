import 'package:alex_poker/app/poker/domain/entities/card.dart';

import 'player.dart';

enum SeatAction {
  fold,
  check,
  raise,
  winner,
  call
}

class Seat {
  const Seat({
    required this.id,
    required this.player,
    required this.buyIn,
    required this.stack,
    required this.hand,
    required this.bet,
    required this.turn,
    required this.checked,
    required this.folded,
    required this.lastAction,
    required this.sittingOut
  });
  final String id;
  final Player player;
  final int buyIn;
  final int stack;
  final List<Card> hand;
  final int bet;
  final bool turn;
  final bool checked;
  final bool folded;
  final SeatAction lastAction;
  final bool sittingOut;
}