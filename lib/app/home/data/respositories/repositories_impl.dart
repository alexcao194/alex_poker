import 'package:alex_poker/core/extension/string_extension.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../core/data/datasources/cache_data.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/remote_data.dart';
import '../models/user.dart';

class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.remoteData, required this.coreCacheData});
  final RemoteData remoteData;
  final CoreCacheData coreCacheData;
  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      return Right(await remoteData.getProfile(token: coreCacheData.getToken() ?? "", ip: coreCacheData.getIP4()));
    } on DioError catch(e) {
      print(e);
      return Left(Failure(message: ' '.join(e.error.toString().split(RegExp(r'-'))).caption()));
    }
  }
}
