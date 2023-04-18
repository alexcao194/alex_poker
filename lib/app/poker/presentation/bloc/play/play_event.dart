part of 'play_bloc.dart';

abstract class PlayEvent extends Equatable {
  const PlayEvent();
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