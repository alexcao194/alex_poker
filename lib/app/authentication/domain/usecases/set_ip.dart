import '../repositories/repositories.dart';

class SetIp {
  const SetIp({required this.repositories});
  final Repositories repositories;

  void call(String ip) async {
    return  repositories.setIp(ip);
  }
}