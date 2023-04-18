

import '../entities/account.dart';
import '../repositories/repositories.dart';

class GetAccount {
  const GetAccount({required this.repositories});
  final Repositories repositories;

  Account call() {
    return repositories.getAccount();
  }
}