import 'package:alex_poker/app/authentication/data/models/account.dart';
import 'package:alex_poker/app/authentication/domain/entities/account.dart';

import '../../../../core/error/failures.dart';

abstract class Repositories {
  const Repositories();
  Future<Failure?> login(AccountModal account);
  Future<Failure?> signup(AccountModal account);
  void setIp(String ip);
  Account getAccount();
}