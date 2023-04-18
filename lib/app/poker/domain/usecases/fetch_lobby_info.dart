import '../repositories/repositories.dart';

class FetchLobbyInfo {
  const FetchLobbyInfo({required this.repositories});
  final Repositories repositories;

  void call(int type) {
    repositories.fetchLobbyInfo(type);
  }
}