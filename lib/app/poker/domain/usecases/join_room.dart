import '../repositories/repositories.dart';

class JoinRoom {
  const JoinRoom({required this.repositories});
  final Repositories repositories;

  void call(String id) {
    repositories.joinRoom(id);
  }
}