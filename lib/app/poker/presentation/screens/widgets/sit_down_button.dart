import 'package:alex_poker/config/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../../../config/app_paths.dart';
import '../../../../core/presentation/widget/rounded_box.dart';
class SitDownButton extends StatelessWidget {
  const SitDownButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: const Color.fromARGB(255, 38, 140, 165),
              width: 2
          )
      ),
      child: const Padding(
        padding: EdgeInsets.all(2.5),
        child: RoundedBox(
          radius: 16,
          height: 50,
          width: 50,
          child: Icon(Icons.add, color: AppColors.primaryWhite),
        ),
      ),
    );
  }
}