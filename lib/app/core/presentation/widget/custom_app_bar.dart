import 'package:flutter/material.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_fonts.dart';
import '../../../../config/app_paths.dart';

class CustomAppBar extends AppBar {
  final int chip;
  CustomAppBar({
    super.key,
    required this.context,
    required this.chip
  }) : super(
    backgroundColor: Colors.transparent,
    leading: ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(35.0), bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      child: Container(
        decoration: const BoxDecoration(
            color: AppColors.primaryBackground,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(35.0), bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0), topRight: Radius.circular(15.0))),
        child: Image.asset(AppPath.asset_1, fit: BoxFit.cover),
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 30.0, width: 30.0, child: Image.asset(AppPath.coin, fit: BoxFit.cover)),
        const SizedBox(width: 4.0),
        Text(chip.toString(), style: Theme.of(context).textTheme.titleSmall!.copyWith(color: AppColors.subWhite, fontFamily: AppFonts.superBoom))
      ],
    ),
    actions: const [
      CircleAvatar(
        backgroundColor: Colors.transparent,
      )
    ],
  );

  final BuildContext context;
}
