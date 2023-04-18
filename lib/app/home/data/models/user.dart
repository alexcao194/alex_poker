import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.email, required super.username, required super.chipAmount});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'],
        username: json['name'],
        chipAmount: json['chipAmount']
    );
  }

  Map<String, dynamic> toJson() {
    return {

    };
  }
}