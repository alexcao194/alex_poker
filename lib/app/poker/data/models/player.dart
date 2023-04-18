import 'package:alex_poker/app/poker/domain/entities/player.dart';

class PlayerModel extends Player {
  PlayerModel({required super.name, required super.bankroll});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
        name: json['name'],
        bankroll: json['bankroll']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name' : name,
      'bankroll' : bankroll
    };
  }
}