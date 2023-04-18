part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();
}

class RoomEventSendData extends RoomEvent {
  const RoomEventSendData({required this.data});
  final dynamic data;
  @override
  List<Object?> get props => [data];
}

class RoomEventSendError extends RoomEvent {
  const RoomEventSendError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}


class RoomEventConnect extends RoomEvent {
  @override
  List<Object?> get props => [];
}

class RoomEventDisConnect extends RoomEvent {
  @override
  List<Object?> get props => [];
}

class RoomEventGetRoom extends RoomEvent {
  const RoomEventGetRoom({required this.roomPage});
  final RoomPage roomPage;
  @override
  List<Object?> get props => [roomPage];
}

class RoomEventJoin extends RoomEvent {
  const RoomEventJoin({required this.id});
  final String id;
  @override
  List<Object?> get props => [id];
}

class RoomEventLeave extends RoomEvent {
  const RoomEventLeave({required this.id});
  final String id;
  @override
  List<Object?> get props => [id];
}