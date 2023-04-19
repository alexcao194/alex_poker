import 'package:alex_poker/core/services/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/app_colors.dart';
import '../../../../../core/services/notification/notification.dart';
import '../../../../core/presentation/widget/rounded_shadow_box.dart';
import '../../bloc/play/play_bloc.dart';

enum Actions { standUp, exitNow, exit, shitDown }

extension ActionsExtention on Actions {
  String get name {
    switch (this) {
      case Actions.exit:
        return 'Exit';
      case Actions.exitNow:
        return 'Exit Now';
      case Actions.standUp:
        return 'Stand up';
      case Actions.shitDown:
        return 'Shit down';
    }
  }

  IconData get icon {
    switch (this) {
      case Actions.exit:
        return Icons.check;
      case Actions.exitNow:
        return Icons.arrow_back_sharp;
      case Actions.standUp:
        return Icons.arrow_upward_sharp;
      case Actions.shitDown:
        return Icons.arrow_downward_sharp;
    }
  }
}

class DropMenu extends StatefulWidget {
  const DropMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<DropMenu> createState() => DropMenuState();
}

class DropMenuState extends State<DropMenu> {
  final Duration _duration = const Duration(milliseconds: 300);
  final List<bool> _visible = [];
  final int _itemCount = 3;
  bool _standing = false;
  bool _appear = false;
  final List<bool?> _state = [null, null, false];

  @override
  void initState() {
    for (int i = 0; i < _itemCount; i++) {
      _visible.add(false);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayBloc, PlayState>(
      builder: (context, playState) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          height: _appear ? 300 : 50,
          width: _appear ? 450 : 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RoundedShadowBox(
                radius: 20,
                height: 50,
                width: 50,
                shadowColor: (_visible[0] ? null : AppColors.primaryBackground),
                child: MaterialButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    _changeState();
                  },
                  child: const Icon(Icons.menu, color: AppColors.primaryWhite),
                ),
              ),
                if(_visible.first) SizedBox(
                width: 200,
                height: 400,
                child: ListView.builder(
                    itemCount: _itemCount,
                    itemBuilder: (context, index) {
                      return AnimatedOpacity(
                        duration: _duration,
                        opacity: _visible[index] ? 1 : 0,
                        curve: Curves.easeOut,
                        child: AnimatedAlign(
                          duration: _duration,
                          curve: Curves.easeOut,
                          alignment: _visible[index] ? Alignment.centerLeft : Alignment.centerRight,
                          child: dropItem(state: _state[index], action: Actions.values[index], roomId: (playState as PlayStatePlaying).room.id),
                        ),
                      );
                    }),
              )
            ],
          ),
        );
      },
    );
  }

  dropItem({required bool? state, required Actions action, required String roomId}) {
    if (action == Actions.standUp && _standing) action = Actions.shitDown;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0) + const EdgeInsets.only(left: 8.0),
      child: RoundedShadowBox(
        radius: 15,
        width: 140,
        height: 40,
        blurRadius: 10,
        spreadRadius: 2,
        child: MaterialButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            _onPress(action, roomId);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(action.icon, color: (state == null || state) ? AppColors.primaryWhite : Colors.transparent),
                ),
                Text(
                  action.name,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.primaryWhite),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _changeState() {
    if(!_appear) {
      setState(() {
        _appear = true;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        _appearDropItem();
      });
    } else {
      _appearDropItem();
      Future.delayed(Duration(milliseconds: 200 * _itemCount), () {
        setState(() {
          _appear = false;
        });
      });
    }
  }

  void _onPress(Actions action, String roomId) {
    _changeState();
    int index = Actions.values.indexOf(action);
    switch (action) {
      case Actions.standUp:
        setState(() {
          _standing = true;
        });
        break;
      case Actions.exitNow:
        AppNotification.showAlertDialog(
            message: 'Exiting the table if you are placing a bet will lose your bet, are you sure you want to exit?',
            onAccept: () {
              BlocProvider.of<PlayBloc>(context).add(PlayEventLeave(roomId: roomId));
              AppRouter.pop();
            },
            onCancel: () {});
        break;
      case Actions.exit:
        _state[index] = !_state[index]!;
        break;
      case Actions.shitDown:
        setState(() {
          _standing = false;
        });
        break;
    }
  }

  void _appearDropItem() {
    for (int i = 0; i < _itemCount; i++) {
      Future.delayed(Duration(milliseconds: 200 * i)).then((value) {
        if (mounted) {
          setState(() {
            _visible[i] = !_visible[i];
          });
        }
      });
    }
  }
}
