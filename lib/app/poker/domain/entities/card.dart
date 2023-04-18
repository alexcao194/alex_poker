enum TypeCard {
  carreaux,
  coueurs,
  piques,
  trefles
}

class Card {
  const Card({required this.type, required this.value});
  final String value;
  final TypeCard type;
}