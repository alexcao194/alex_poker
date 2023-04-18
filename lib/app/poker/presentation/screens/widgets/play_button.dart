import 'package:alex_poker/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/entypo_icons.dart';

enum PlayActions {
  foldIfRaise,
  bet,
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

  final BorderRadius _betBorderRadius = const BorderRadius.only(
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

  final BorderRadius _foldIfRaisedBorderRadius = const BorderRadius.only(
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
            onPressed: () {

            },
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

      case PlayActions.foldIfRaise:
        return _foldIfRaisedBorderRadius;
      case PlayActions.bet:
        return _betBorderRadius;
      case PlayActions.call:
        return _callBorderRadius;
      case PlayActions.fold:
        return _foldBorderRadius;
    }
  }

  IconData _getIconData() {
    switch(playActions) {
      case PlayActions.foldIfRaise:
        return Icons.directions_run;
      case PlayActions.bet:
        return Icons.add;
      case PlayActions.call:
        return Icons.check;
      case PlayActions.fold:
        return Entypo.cancel;
    }
  }
}