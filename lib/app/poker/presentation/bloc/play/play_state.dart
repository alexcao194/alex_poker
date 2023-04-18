part of 'play_bloc.dart';

abstract class PlayState extends Equatable {
  const PlayState();
}

class PlayInitial extends PlayState {
  @override
  List<Object> get props => [];
}

class PlayStatePlaying extends PlayState {
  const PlayStatePlaying({required this.room});
  final Room room;
  @override
  List<Object?> get props => [room];
}
