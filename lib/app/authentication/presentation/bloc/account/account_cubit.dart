import 'package:bloc/bloc.dart';

import '../../../domain/entities/account.dart';
import '../../../domain/usecases/get_account.dart';

class AccountCubit extends Cubit<Account> {
  AccountCubit({required this.getAccount}) : super(const Account(name: '', email: '', password: ''));

  final GetAccount getAccount;

  void get() {
    emit(getAccount.call());
  }
}
