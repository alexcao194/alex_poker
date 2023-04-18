import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_fonts.dart';
import '../../../../../config/app_paths.dart';
import '../../../../core/presentation/widget/rounded_shadow_box.dart';




class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Cao Việt Đức', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: AppColors.primaryWhite,
                fontWeight: FontWeight.bold
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('19042003', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: AppColors.subWhite,
                    fontFamily: AppFonts.superBoom
                )),
                const SizedBox(width: 4.0),
                SizedBox(height: 15.0, width: 15.0, child: Image.asset(AppPath.coin, fit: BoxFit.cover)),
              ],
            ),
          ],
        ),
        const SizedBox(width: 8.0),
        RoundedShadowBox(
            radius: 20,
            height: 50,
            width: 50,
            color: AppColors.primaryBackground,
            child: Image.asset(AppPath.asset_1, fit: BoxFit.cover)
        ),
      ],
    );
  }
}