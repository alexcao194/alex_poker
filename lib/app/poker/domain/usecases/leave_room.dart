import '../repositories/repositories.dart';

class LeaveRoom {
  const LeaveRoom({required this.repositories});
  final Repositories repositories;

  void call(String id) {
    repositories.leaveRoom(id);
  }
}