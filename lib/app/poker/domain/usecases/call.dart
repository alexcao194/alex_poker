import '../repositories/repositories.dart';

class Call {
  const Call({required this.repositories});
  final Repositories repositories;

  void call(String roomId) {
    repositories.call(roomId);
  }
}