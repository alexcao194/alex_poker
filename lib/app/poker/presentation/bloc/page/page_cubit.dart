import 'package:alex_poker/core/services/app_router/app_router.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../room/room_bloc.dart';

enum RoomPage {
  normal,
  rank,
  vip1,
  vip2;

  String get string {
    String value = toString().split('.').last;
    return String.fromCharCode(value.codeUnits[0] - 32) + value.substring(1);
  }
}

class PageCubit extends Cubit<RoomPage> {
  PageCubit() : super(RoomPage.normal);
  void change(RoomPage page, {PageController? controller}) {
    if(controller != null) {
      controller.animateToPage(
          RoomPage.values.indexOf(page),
          duration: const Duration(milliseconds: 300),
          curve: Curves.linearToEaseOut
      );
    }
    emit(page);
    BlocProvider.of<RoomBloc>(AppRouter.context).add(RoomEventGetRoom(roomPage: page));
  }
}