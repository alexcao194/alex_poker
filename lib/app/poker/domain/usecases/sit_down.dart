import '../repositories/repositories.dart';

class SitDown {
  final Repositories repositories;
  const SitDown({required this.repositories});

  void call(String tableId, int seatId, int amount) {
    repositories.sitDown(tableId, seatId, amount);
  }
}