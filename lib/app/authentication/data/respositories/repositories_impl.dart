
import 'dart:convert';

import 'package:alex_poker/core/extension/string_extension.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/failures.dart';
import '../../../core/data/datasources/cache_data.dart';
import '../../domain/entities/account.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/cache_data.dart';
import '../datasources/remote_data.dart';
import '../models/account.dart';


class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.remoteData, required this.cacheData, required this.coreCacheData});
  final RemoteData remoteData;
  final CacheData cacheData;
  final CoreCacheData coreCacheData;

  @override
  Future<Failure?> login(AccountModal account) async {
    cacheData.cacheAccount(account);
    try {
      var token = await remoteData.login(account, coreCacheData.getIP4());
      if(token != null) {
        coreCacheData.cacheToken(token);
      }
    } on DioError catch (e) {
      return Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption());
    }
    return null;
  }

  @override
  Future<Failure?> signup(AccountModal account) async {
    cacheData.cacheAccount(account);
    try {
      var token = await remoteData.signup(account, coreCacheData.getIP4());
      if(token != null) {
        coreCacheData.cacheToken(token);
      }
    } on DioError catch (e) {
      return Failure(message: ' '.join(e.error.toString().split(RegExp(r'[-]'))).caption());
    }
    return null;
  }

  @override
  Account getAccount() {
    return cacheData.getAccount();
  }

  @override
  void setIp(String ip) async {
    coreCacheData.setIP4(ip);
  }
}