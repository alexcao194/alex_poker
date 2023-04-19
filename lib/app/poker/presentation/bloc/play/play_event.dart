part of 'play_bloc.dart';

abstract class PlayEvent extends Equatable {
  const PlayEvent();
}

class PlayEventSendData extends PlayEvent {
  const PlayEventSendData({required this.data});
  final dynamic data;
  @override
  List<Object?> get props => [data];
}

class PlayEventSendError extends PlayEvent {
  const PlayEventSendError({required this.message});
  final String message;
  @override
  List<Object?> get props => [message];
}

class PlayEventConnect extends PlayEvent {
  @override
  List<Object?> get props => [];
}

class PlayEventJoin extends PlayEvent {
  const PlayEventJoin({required this.id});
  final String id;
  @override
  List<Object?> get props => [id];
}

class PlayEventLeave extends PlayEvent {
  const PlayEventLeave({required this.roomId});
  final String roomId;
  @override
  List<Object?> get props => [roomId];
}

class PlayEventSitDown extends PlayEvent {
  const PlayEventSitDown({required this.amount, required this.seatId, required this.tableId});
  final int seatId;
  final String tableId;
  final int amount;

  @override
  List<Object?> get props => [amount, seatId, tableId];
}

class PlayEventCall extends PlayEvent {
  const PlayEventCall({required this.roomId});
  final String roomId;

  @override
  List<Object?> get props => [roomId];
}

class PlayEventCheck extends PlayEvent {
  const PlayEventCheck({required this.roomId});
  final String roomId;

  @override
  List<Object?> get props => [roomId];
}

class PlayEventFold extends PlayEvent {
  const PlayEventFold({required this.roomId});
  final String roomId;

  @override
  List<Object?> get props => [roomId];
}

class PlayEventRaise extends PlayEvent {
  const PlayEventRaise({required this.roomId, required this.amount});
  final String roomId;
  final int amount;
  @override
  List<Object?> get props => [roomId];
}