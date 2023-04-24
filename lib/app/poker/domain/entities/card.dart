enum Suit { carreaux, coueurs, piques, trefles }

enum PokerHand {
  highCard,
  onePair,
  twoPair,
  threeOfAKind,
  straight,
  flush,
  fullHouse,
  fourOfAKind,
  straightFlush,
  royalFlush,
}


class Card {
  const Card({required this.suit, required this.rank});

  final String rank;
  final Suit suit;

  static const List<String> _rank = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'];
  static PokerHand _currentHand = PokerHand.highCard;

  static List<Card> _isRoyalStraight(List<Card> cards) {
    if (cards.length != 5) {
      return [];
    }
    Suit firstSuit = cards[0].suit;
    for (int i = 1; i < cards.length; i++) {
      if (cards[i].suit != firstSuit) {
        return [];
      }
    }
    List<String> ranks = ["10", "J", "Q", "K", "A"];
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].rank != ranks[i]) {
        return [];
      }
    }
    return cards;
  }

  static List<Card> _isStraightFlush(List<Card> cards) {
    if (cards.length != 5) {
      return [];
    }
    Suit firstSuit = cards[0].suit;
    for (int i = 1; i < cards.length; i++) {
      if (cards[i].suit != firstSuit) {
        return [];
      }
    }
    int startRankValue = _rank.indexOf(cards[0].rank);
    startRankValue = startRankValue == _rank.indexOf('A') ? -1 : startRankValue;
    for (int i = 1; i < cards.length; i++) {
      int currentRankValue = _rank.indexOf(cards[i].rank);
      if (currentRankValue != startRankValue + i) {
        return [];
      }
    }
    return cards;
  }

  static List<Card> _isFourOfAKind(List<Card> cards) {
    List<Card> result = [cards.first];
    int count = 1;
    for (int i = 0; i < cards.length - 1; i++) {
      if (cards[i].rank == cards[i + 1].rank) {
        count++;
        result.add(cards[i + 1]);
      } else {
        count = 1;
        result.clear();
        result.add(cards[i]);
      }
      if (count == 4) {
        return result;
      }
    }
    return [];
  }

  static List<Card> _isFullHouse(List<Card> cards) {
    if ((cards[0].rank == cards[1].rank && cards[1].rank == cards[2].rank && cards[3].rank == cards[4].rank) ||
        (cards[0].rank == cards[1].rank && cards[2].rank == cards[3].rank && cards[3].rank == cards[4].rank)) {
      return cards;
    }
    return [];
  }

  static List<Card> _isFlush(List<Card> cards) {
    for (int i = 0; i < cards.length - 1; i++) {
      if (cards[i].suit != cards[i + 1].suit) {
        return [];
      }
    }
    return cards;
  }

  static List<Card> _isStraight(List<Card> cards) {
    if (cards.first.rank == '2' && cards.last.rank == 'A') {
      bool has2345 = true;
      for (int i = 1; i < 4; i++) {
        if (Card._rank.indexOf(cards[i].rank) != Card._rank.indexOf(cards[i - 1].rank) + 1) {
          has2345 = false;
          break;
        }
      }
      return has2345 ? cards : [];
    }
    bool hasStraight = true;
    for (int i = 1; i < cards.length; i++) {
      if (Card._rank.indexOf(cards[i].rank) != Card._rank.indexOf(cards[i - 1].rank) + 1) {
        hasStraight = false;
        break;
      }
    }
    return hasStraight ? cards : [];
  }

  static List<Card> _isThreeOfAKind(List<Card> cards) {
    for (int i = 0; i < cards.length - 2; i++) {
      if (cards[i].rank == cards[i + 1].rank && cards[i + 1].rank == cards[i + 2].rank) {
        return cards.sublist(i, i + 3);
      }
    }
    return [];
  }

  static List<Card> _isTwoPair(List<Card> cards) {
    List<Card> pairs = [];
    for (int i = 0; i < cards.length - 1; i++) {
      if (cards[i].rank == cards[i + 1].rank) {
        pairs.addAll(cards.sublist(i, i + 2));
      }
    }
    if(pairs.length > 2) {
      return pairs.sublist(pairs.length - 4, pairs.length);
    } else {
      return [];
    }
  }

  static List<Card> _isPair(List<Card> cards) {
    for (int i = 0; i < cards.length - 1; i++) {
      if (cards[i].rank == cards[i + 1].rank) {
        return [...cards.sublist(i, i + 2)];
      }
    }
    return [];
  }

  static List<List<Card>> _generateAllHands(List<Card> cards) {
    List<List<Card>> hands = [];
    void generateHelper(int start, int count, List<Card> hand) {
      if (count == 5) {
        hands.add(hand);
        return;
      }

      for (int i = start; i < cards.length; i++) {
        List<Card> newHand = List.from(hand);
        newHand.add(cards[i]);
        generateHelper(i + 1, count + 1, newHand);
      }
    }
    generateHelper(0, 0, []);
    return hands;
  }


  static List<Card> _getHandValue(List<Card> cards) {
    var result = _isRoyalStraight(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.royalFlush;
      return result;
    }
    result = _isStraightFlush(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.straightFlush;
      return result;
    }
    result = _isFourOfAKind(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.fourOfAKind;
      return result;
    }
    result = _isFullHouse(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.fullHouse;
      return result;
    }
    result = _isFlush(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.flush;
      return result;
    }
    result = _isStraight(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.straight;
      return result;
    }
    result = _isThreeOfAKind(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.threeOfAKind;
      return result;
    }
    result = _isTwoPair(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.twoPair;
      return result;
    }
    result = _isPair(cards);
    if(result.isNotEmpty) {
      _currentHand = PokerHand.onePair;
      return result;
    }
    _currentHand = PokerHand.highCard;
    return [];
  }

  static List<bool> getSet(List<Card> board, List<Card> hand) {
    List<Card> originCards = [...board, ...hand];
    List<Card> cards = [...board, ...hand]..sort((a, b) => _rank.indexOf(a.rank) - _rank.indexOf(b.rank));
    var sets = _generateAllHands(cards);
    var bestSet = sets.first;
    var bestHand = PokerHand.highCard;
    for (var set in sets) {
      var handValue = _getHandValue(cards.where((card) => set.contains(card)).toList());
      if (PokerHand.values.indexOf(_currentHand) >= PokerHand.values.indexOf(bestHand)) {
        bestHand = _currentHand;
        bestSet.clear();
        bestSet = [...handValue];
      }
    }
    return [for(int i = 0; i < originCards.length; i++) bestSet.contains(originCards[i])];
  }
}
