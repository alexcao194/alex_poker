import '../repositories/repositories.dart';

class Raise {
  const Raise({required this.repositories});
  final Repositories repositories;

  void call(String roomId, int amount) {
    repositories.raise(roomId, amount);
  }
}