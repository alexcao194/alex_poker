import '../../../../core/error/failures.dart';
import '../../data/models/account.dart';
import '../entities/account.dart';
import '../repositories/repositories.dart';

class Login {
  const Login({required this.repositories});
  final Repositories repositories;

  Future<Failure?> call(Account account) async {
    if(account.email.isEmpty) {
      return const Failure(message: 'Email is empty');
    }
    if(account.password.isEmpty) {
      return const Failure(message: 'Password is empty');
    }
    return await repositories.login(
        AccountModal(password: account.password, name: account.name, email: account.email)
    );
  }
}