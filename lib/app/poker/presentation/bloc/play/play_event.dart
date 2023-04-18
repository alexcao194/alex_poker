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
  const PlayEventLeave({required this.id});
  final String id;
  @override
  List<Object?> get props => [id];
}