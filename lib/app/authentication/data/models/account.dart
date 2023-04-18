
import '../../domain/entities/account.dart';

class AccountModal extends Account {
  const AccountModal({
    required super.password,
    super.rePassword,
    required super.name,
    required super.email
});

  factory AccountModal.fromJson(Map<String, dynamic> json) {
    return AccountModal(
      password: json['password'],
      rePassword: json['re-password'],
      name: json['name'],
      email: json['email']
    );
  }

  static Map<String, dynamic> toJson(AccountModal accountModal) {
    return {
      'password' : accountModal.password,
      're-password' : accountModal.rePassword,
      'email' : accountModal.email,
      'name' : accountModal.name
    };
  }
}