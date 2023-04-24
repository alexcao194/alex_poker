import 'dart:math';
import 'package:alex_poker/config/app_colors.dart';
import 'package:alex_poker/config/app_paths.dart';
import 'package:alex_poker/core/services/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../config/app_fonts.dart';
import '../../../../home/presentation/bloc/user_profile_bloc.dart';

enum InitType {
  min,
  max
}

class PickAmountDiaLog extends StatefulWidget {
  const PickAmountDiaLog({
    super.key,
    required this.maxAmount,
    required this.minAmount,
    required this.action,
    required this.initType
  });

  final int minAmount;
  final int maxAmount;
  final InitType initType;
  final Function(int) action;

  @override
  State<PickAmountDiaLog> createState() => _PickAmountDiaLogState();
}

class _PickAmountDiaLogState extends State<PickAmountDiaLog> {
  double _amount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, userState) {
        userState as UserProfileStateGetSuccessful;
        if (_amount == 0) {
          if(widget.initType == InitType.max) {
            _amount = min(widget.maxAmount.toDouble(), userState.user.chipAmount.toDouble());
          } else {
            _amount = widget.minAmount.toDouble();
          }
        }
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AlertDialog(
              backgroundColor: AppColors.primary,
              content: Column(
                children: [
                  Slider(
                      min: widget.minAmount.toDouble(),
                      max: min(widget.maxAmount.toDouble(), userState.user.chipAmount.toDouble()),
                      value: _amount,
                      onChanged: (amount) {
                        setState(() {
                          _amount = amount;
                        });
                      }
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(AppPath.chip, height: 20),
                      ),
                      Text((_amount ~/ 1).toString(),
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(fontFamily: AppFonts.superBoom, color: AppColors.primaryWhite),
                      ),
                    ],
                  ),
                ],
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                MaterialButton(
                  onPressed: () {
                    AppRouter.pop();
                  },
                  child: Text('Cancel',
                      style: Theme.of(context).textTheme.labelSmall!.copyWith(fontFamily: AppFonts.superBoom, color: AppColors.primaryWhite),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    AppRouter.pop();
                    widget.action(_amount.toInt());
                  },
                  child: Text('Join',
                    style: Theme.of(context).textTheme.labelSmall!.copyWith(fontFamily: AppFonts.superBoom, color: AppColors.primaryWhite),
                  ),
                )
              ],
            ),
          ],
        );
      },
    );
  }
}
