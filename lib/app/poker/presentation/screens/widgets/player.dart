import 'package:alex_poker/config/app_fonts.dart';
import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_paths.dart';
import '../../../../core/presentation/widget/rounded_box.dart';

enum LabelOriented {
  right,
  left,
  none
}

class Player extends StatelessWidget {
  const Player({
    Key? key,
    required this.isActive,
    this.oriented = LabelOriented.none,
    required this.name,
    required this.pot,
    required this.bet
  }) : super(key: key);

  final bool isActive;
  final LabelOriented oriented;
  final String name;
  final int pot;
  final int bet;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(oriented == LabelOriented.left) Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Column(
            children: [
              Text(name, style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.primaryWhite,
                  fontFamily: AppFonts.superBoom
              )),
              Text('\$$pot', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.primaryWhite
              )),
              Text('bet: \$$bet', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.primaryWhite
              )),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  color: isActive ? const Color.fromARGB(255, 38, 140, 165) : Colors.transparent,
                  width: 2
              )
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: RoundedBox(
              radius: 16,
              height: 50,
              width: 50,
              child: Image.asset(AppPath.asset_1, fit: BoxFit.cover),
            ),
          ),
        ),
        if(oriented == LabelOriented.right) Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            children: [
              Text(name, style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.primaryWhite,
                fontFamily: AppFonts.superBoom
              )),
              Text('\$$pot', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.primaryWhite
              )),
              Text('bet: \$$bet', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: AppColors.primaryWhite
              )),
            ],
          ),
        )
      ],

    );
  }
}