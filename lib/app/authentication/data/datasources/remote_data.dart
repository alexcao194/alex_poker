import 'dart:convert';

import 'package:alex_poker/app/authentication/data/models/account.dart';
import 'package:dio/dio.dart';

abstract class RemoteData {
  const RemoteData();
  Future<String?> signup(AccountModal account, String ip);
  Future<String?> login(AccountModal account, String ip);
}

class RemoteDataImpl extends RemoteData {
  const RemoteDataImpl({required this.dio});
  final Dio dio;

  @override
  Future<String?> login(AccountModal account, String ip) async {
    var res = await dio.post('https://$ip/api/auth',
        options: Options(
            contentType: 'application/json',
        ),
        data: json.encode({
          "email" : account.email,
          "password" : account.password
        })
    ).timeout(const Duration(milliseconds: 10000),
        onTimeout: () {
          throw DioError(requestOptions: RequestOptions(path: 'get'), error: 'network error, path : $ip');
        }
    );
    var message = res.data['message'].toString();
    if(message == 'login-successful') {
      return res.data['token'].toString();
    } else {
      throw DioError(requestOptions: RequestOptions(path: 'post-api/auth'), error: message);
    }
  }

  @override
  Future<String?> signup(AccountModal account, String ip) async {
    var res = await dio.post('https://$ip/api/users',
        options: Options(
            contentType: 'application/json'
        ),
        data: json.encode({
          "name" : account.name,
          "password" : account.password,
          "email" : account.email,
        })
    ).timeout(const Duration(milliseconds: 10000),
      onTimeout: () {
        throw DioError(requestOptions: RequestOptions(path: 'post-api/users'), error: 'network error, path : $ip');
      }
    );
    var message = res.data['message'].toString();
    if(message == 'signup-successful') {
      return res.data['token'].toString();
    } else {
      throw DioError(requestOptions: RequestOptions(path: 'post-api/users'), error: message);
    }
  }
}