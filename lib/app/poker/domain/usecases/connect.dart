import 'dart:async';
import 'package:alex_poker/core/services/poker_socket/poker_socket.dart';

import 'package:alex_poker/app/poker/domain/repositories/repositories.dart';

class Connect {
  const Connect({required this.repositories});
  final Repositories repositories;
  Stream<PokerMessage> call() {
    return repositories.connect();
  }
}

