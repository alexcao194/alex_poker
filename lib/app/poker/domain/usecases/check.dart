import '../repositories/repositories.dart';

class Check {
  const Check({required this.repositories});
  final Repositories repositories;

  void call(String roomId) {
    repositories.check(roomId);
  }
}