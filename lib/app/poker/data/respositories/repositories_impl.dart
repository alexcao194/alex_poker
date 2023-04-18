import 'package:alex_poker/app/core/data/datasources/cache_data.dart';
import 'package:alex_poker/app/poker/data/datasources/realtime_data.dart';
import 'package:alex_poker/core/services/poker_socket/poker_socket.dart';
import '../../domain/repositories/repositories.dart';

class RepositoriesImpl extends Repositories {
  const RepositoriesImpl({required this.coreCacheData, required this.realtimeData});
  final RealtimeData realtimeData;
  final CoreCacheData coreCacheData;
  @override
  Stream<PokerMessage> connect() {
    return realtimeData.connect(ip: coreCacheData.getIP4(), token: coreCacheData.getToken() ?? "");
  }

  @override
  void disconnect() {
    realtimeData.disconnect();
  }

  @override
  void fetchLobbyInfo(int type) {
    realtimeData.fetchLobbyInfo(type, coreCacheData.getToken() ?? "");
  }

  @override
  void joinRoom(String id) {
    realtimeData.joinRoom(id);
  }

  @override
  void leaveRoom(String id) {
    realtimeData.leaveRoom(id);
  }
}