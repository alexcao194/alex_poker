import 'package:alex_poker/app/poker/domain/entities/card.dart';

class CardModel extends Card{
  const CardModel({required super.rank, required super.suit});
  factory CardModel.fromJson(Map<String, dynamic> json) {
    Suit suit = Suit.carreaux;
    switch(json['suit']) {
      case 's':
        suit = Suit.carreaux;
        break;
      case 'h':
        suit = Suit.coueurs;
        break;
      case 'd':
        suit = Suit.piques;
        break;
      case 'c':
        suit = Suit.trefles;
        break;
    }
    return CardModel(
      rank: json['rank'],
      suit: suit
    );
  }
}