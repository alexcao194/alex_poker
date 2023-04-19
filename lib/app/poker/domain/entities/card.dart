enum Suit {
  carreaux,
  coueurs,
  piques,
  trefles
}

class Card {
  const Card({required this.suit, required this.rank});
  final String rank;
  final Suit suit;
}