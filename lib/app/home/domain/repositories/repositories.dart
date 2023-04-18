import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../data/models/user.dart';

abstract class Repositories {
  const Repositories();
  Future<Either<Failure, UserModel>> getProfile();
}