part of 'room_bloc.dart';


abstract class RoomState extends Equatable {
  const RoomState();
}

class RoomInitial extends RoomState {
  const RoomInitial();

  @override
  List<Object> get props => [];
}

class RoomStateLoading extends RoomState {
  const RoomStateLoading();

  @override
  List<Object> get props => [];
}

class RoomStateGetFail extends RoomState {
  const RoomStateGetFail({required this.error});
  final String error;

  @override
  List<Object> get props => [error];
}

class RoomStateGetSuccessful extends RoomState {
  const RoomStateGetSuccessful({required this.listRoom});
  final List<Room> listRoom;

  @override
  List<Object> get props => [listRoom];
}