import 'package:alex_poker/app/poker/data/models/player.dart';
import 'package:alex_poker/app/poker/domain/entities/card.dart';
import 'package:alex_poker/app/poker/domain/entities/seat.dart';

import 'card.dart';

class SeatModel extends Seat {
  SeatModel({
    required super.id,
    required super.player,
    required super.buyIn,
    required super.stack,
    required super.hand,
    required super.bet,
    required super.turn,
    required super.checked,
    required super.folded,
    required super.lastAction,
    required super.sittingOut
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) {
    print(json);
    var handData = json['hand'];
    var hand = <Card>[];
    for(var cardData in handData) {
      hand.add(CardModel.fromJson(cardData));
    }
    SeatAction lastAction = SeatAction.check;
    switch (json['lastAction']) {
      case "WINNER":
        lastAction = SeatAction.winner;
        break;
      case "FOLD":
        lastAction = SeatAction.fold;
        break;
      case "RAISE":
        lastAction = SeatAction.raise;
        break;
      case "CHECK":
        lastAction = SeatAction.check;
        break;
      case "CALL":
        lastAction = SeatAction.call;
        break;
    }
    return SeatModel(
        id: json['id'],
        player: PlayerModel.fromJson(json['player']),
        buyIn: json['buyin'],
        stack: json['stack'] ?? 0,
        hand: hand,
        bet: json['bet'] ?? 0,
        turn: json['turn'],
        checked: json['checked'],
        folded: json['folded'],
        lastAction: lastAction,
        sittingOut: json['sittingOut']
    );
  }
}