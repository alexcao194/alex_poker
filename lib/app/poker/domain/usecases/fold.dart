import '../repositories/repositories.dart';

class Fold {
  const Fold({required this.repositories});
  final Repositories repositories;

  void call(String roomId) {
    repositories.fold(roomId);
  }
}