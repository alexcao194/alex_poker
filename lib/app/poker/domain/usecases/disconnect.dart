import '../repositories/repositories.dart';

class Disconnect {
  const Disconnect({required this.repositories});
  final Repositories repositories;

  void call() {
    repositories.disconnect();
  }
}