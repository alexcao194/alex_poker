import 'package:alex_poker/app/poker/domain/entities/card.dart';

class CardModel extends Card{
  const CardModel({required super.value, required super.type});
  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(value: 'value', type: TypeCard.carreaux);
  }
}