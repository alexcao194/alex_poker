import 'dart:convert';

import 'package:alex_poker/app/home/data/models/user.dart';
import 'package:dio/dio.dart';

abstract class RemoteData {
  const RemoteData();
  Future<UserModel> getProfile({required String token, required String ip});
}

class RemoteDataImpl extends RemoteData {
  const RemoteDataImpl({required this.dio});
  final Dio dio;

  @override
  Future<UserModel> getProfile({required String token, required String ip}) async {
    var res = await dio.get('https://$ip/api/auth',
        options: Options(
          contentType: 'application/json',
          headers: {
            'x-auth-token' : token
          }
        ),
    ).timeout(const Duration(milliseconds: 10000),
        onTimeout: () {
          throw DioError(requestOptions: RequestOptions(path: 'get-api/auth'), error: 'network error, path : $ip');
        }
    );
    var message = res.data['message'].toString();
    if(message == 'get-profile-successful') {
      return UserModel.fromJson(res.data['user']);
    } else {
      throw DioError(requestOptions: RequestOptions(path: 'post-api/auth'), error: message);
    }
  }
}
