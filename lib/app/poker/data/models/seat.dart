import 'package:alex_poker/app/poker/data/models/player.dart';
import 'package:alex_poker/app/poker/domain/entities/card.dart';
import 'package:alex_poker/app/poker/domain/entities/seat.dart';

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
    var handData = json['hand'];
    var hand = <Card>[];
    return SeatModel(
        id: json['id'],
        player: PlayerModel.fromJson(json['player']),
        buyIn: json['buyin'],
        stack: json['stack'],
        hand: hand,
        bet: json['bet'],
        turn: json['turn'],
        checked: json['checked'],
        folded: json['folded'],
        lastAction: json['lastAction'],
        sittingOut: json['sittingOut']
    );
  }
}