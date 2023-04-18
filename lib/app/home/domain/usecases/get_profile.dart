import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/repositories.dart';
import 'package:dartz/dartz.dart';

class GetProfile {
  const GetProfile({required this.repositories});
  final Repositories repositories;

  Future<Either<Failure, User>> call() async {
    return await repositories.getProfile();
  }
}