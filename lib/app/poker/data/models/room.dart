import 'package:alex_poker/app/poker/data/models/card.dart';
import 'package:alex_poker/app/poker/data/models/player.dart';
import 'package:alex_poker/app/poker/data/models/seat.dart';
import 'package:alex_poker/app/poker/domain/entities/player.dart';
import 'package:alex_poker/app/poker/domain/entities/room.dart';
import 'package:alex_poker/app/poker/domain/entities/seat.dart';

import '../../domain/entities/card.dart';

class RoomModel extends Room {
  RoomModel({
    required super.id,
    required super.name,
    required super.limit,
    required super.maxPlayers,
    required super.currentNumberPlayers,
    required super.smallBlind,
    required super.bigBlind,
    required super.type,
    super.board,
    super.button,
    super.callAmount,
    super.handOver,
    super.mainPot,
    super.minBet,
    super.minRaise,
    super.players,
    super.pot,
    super.seats,
    super.sidePots,
    super.turn,
    super.winMessage,
    super.message
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    var seats = <int, Seat?>{
      1 : null,
      2 : null,
      3 : null,
      4 : null,
      5 : null
    };
    var board = <Card>[];
    var players = <Player>[];
    if(json['players'] != null) {
      for(var player in json['players']) {
        if(player != null) {
          players.add(PlayerModel.fromJson(player));
        }
      }
    }
    if(json['board'] != null) {
      for (var card in json['board']) {
        if (card != null) {
          board.add(CardModel.fromJson(card));
        }
      }
    }
    if(json['seats'] != null) {
      for (int i = 1; i <= 5; i++) {
        seats[i] = json['seats'][i.toString()] != null ? SeatModel.fromJson(json['seats'][i.toString()]) : null;
      }
    }
    return RoomModel(
      id : json['id'],
      name : json['name'],
      limit : json['limit'],
      maxPlayers : json['maxPlayers'],
      currentNumberPlayers : json['currentNumberPlayers'],
      smallBlind : json['smallBlind'],
      bigBlind : json['bigBlind'],
      type : json['type'],
      board: board,
      button: json['button'] ?? 0,
      callAmount: json['callAmount'] ?? 0,
      handOver: json['handOver'] ?? true,
      mainPot: json['mainPot'] ?? 0,
      minBet: json['minBet'] ?? 0,
      minRaise: json['minRaise'] ?? 0,
      players: players,
      pot: json['pot'] ?? 0,
      seats: seats,
      sidePots: [],
      turn: json['turn'] ?? 0,
      winMessage: json['winMessages'] != null ? [for(var message in json['winMessages']) message.toString()] : [],
      message : json['message'] ?? ""
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['limit'] = limit;
    data['maxPlayers'] = maxPlayers;
    data['currentNumberPlayers'] = currentNumberPlayers;
    data['smallBlind'] = smallBlind;
    data['bigBlind'] = bigBlind;
    data['type'] = type;
    return data;
  }
}