import 'package:alex_poker/config/app_colors.dart';
import 'package:alex_poker/core/services/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/entypo_icons.dart';

import '../../bloc/play/play_bloc.dart';

enum PlayActions {
  check,
  raise,
  call,
  fold
}

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.playActions,
    this.active
  });

  final PlayActions playActions;
  final bool? active;
  final BorderRadius _callBorderRadius = const BorderRadius.only(
      bottomRight:Radius.circular(15),
      bottomLeft: Radius.circular(30.0),
      topLeft: Radius.circular(15),
    topRight: Radius.circular(5)
  );

  final BorderRadius _raiseBorderRadius = const BorderRadius.only(
      topRight:Radius.circular(15),
      bottomLeft: Radius.circular(15.0),
      topLeft: Radius.circular(30.0),
    bottomRight: Radius.circular(5)
  );

  final BorderRadius _foldBorderRadius = const BorderRadius.only(
      bottomLeft: Radius.circular(15),
      bottomRight: Radius.circular(30.0),
      topRight: Radius.circular(15),
    topLeft: Radius.circular(5)
  );

  final BorderRadius _check = const BorderRadius.only(
      bottomRight:Radius.circular(15),
      topRight: Radius.circular(30.0),
      topLeft: Radius.circular(15),
      bottomLeft: Radius.circular(5)
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: _getBorderRadius(),
        child: Container(
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: (active == true) ? AppColors.deepSkyBlue : AppColors.primaryBackground,
              borderRadius: _getBorderRadius()
          ),
          child: MaterialButton(
            onPressed: (active == true) ? () {
              _call();
            } : null,
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              _getIconData(),
              color: AppColors.primaryWhite,
            ),
          ),
        ),
      ),
    );
  }

  _getBorderRadius() {
    switch(playActions) {
      case PlayActions.check:
        return _check;
      case PlayActions.raise:
        return _raiseBorderRadius;
      case PlayActions.call:
        return _callBorderRadius;
      case PlayActions.fold:
        return _foldBorderRadius;
    }
  }

  IconData _getIconData() {
    switch(playActions) {
      case PlayActions.check:
        return Icons.check;
      case PlayActions.raise:
        return Icons.add;
      case PlayActions.call:
        return Icons.add_call;
      case PlayActions.fold:
        return Entypo.cancel;
    }
  }

  void _call() {
    var roomId = (BlocProvider.of<PlayBloc>(AppRouter.context).state as PlayStatePlaying).room.id;
    switch(playActions) {
      case PlayActions.check:
        BlocProvider.of<PlayBloc>(AppRouter.context).add(PlayEventCheck(roomId: roomId));
        break;
      case PlayActions.raise:
        BlocProvider.of<PlayBloc>(AppRouter.context).add(PlayEventRaise(roomId: roomId, amount: 500));
        break;
      case PlayActions.call:
        BlocProvider.of<PlayBloc>(AppRouter.context).add(PlayEventCall(roomId: roomId));
        break;
      case PlayActions.fold:
        BlocProvider.of<PlayBloc>(AppRouter.context).add(PlayEventFold(roomId: roomId));
        break;
    }
  }
}