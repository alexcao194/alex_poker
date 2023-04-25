import 'package:shared_preferences/shared_preferences.dart';

abstract class CoreCacheData {
  const CoreCacheData();
  void cacheToken(String token);
  String? getToken();
  void setIP4(String ip);
  String getIP4();
}

class CoreCacheDataImpl extends CoreCacheData {
  const CoreCacheDataImpl({required this.sharedPreferences});
  final String _tokenKey = 'token-key';
  final String _ipKey = 'ip-key';

  final SharedPreferences sharedPreferences;

  @override
  String? getToken() {
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  void cacheToken(String token) async {
    await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  String getIP4() {
    return 'alex-server-5sk7.onrender.com';
    String? ip = sharedPreferences.getString(_ipKey);
    if(ip == null) {
      return '';
    } else {
      return ip;
    }
  }

  @override
  void setIP4(String ip) async {
    await sharedPreferences.setString(_ipKey, ip);
  }
}