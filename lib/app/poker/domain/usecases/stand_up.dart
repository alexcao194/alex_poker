import '../repositories/repositories.dart';

class StandUp {
  const StandUp({required this.repositories});
  final Repositories repositories;

  void call(String roomId) {
    repositories.standUp(roomId);
  }
}