import 'package:alex_poker/app/poker/domain/entities/room.dart';

class RoomModel extends Room {
  RoomModel({
    required super.id,
    required super.name,
    required super.limit,
    required super.maxPlayers,
    required super.currentNumberPlayers,
    required super.smallBlind,
    required super.bigBlind,
    required super.type
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id : json['id'],
      name : json['name'],
      limit : json['limit'],
      maxPlayers : json['maxPlayers'],
      currentNumberPlayers : json['currentNumberPlayers'],
      smallBlind : json['smallBlind'],
      bigBlind : json['bigBlind'],
      type : json['type']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['limit'] = limit;
    data['maxPlayers'] = maxPlayers;
    data['currentNumberPlayers'] = currentNumberPlayers;
    data['smallBlind'] = smallBlind;
    data['bigBlind'] = bigBlind;
    data['type'] = type;
    return data;
  }
}