import 'package:alex_poker/config/app_paths.dart';
import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../core/presentation/widget/rounded_shadow_box.dart';

class PlayingBackground extends StatelessWidget {
  const PlayingBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Center(
      child: RoundedShadowBox(
        radius: 500,
        height: size.height * 0.8,
        width: size.width * 0.7,
        blurRadius: 20,
        spreadRadius: 5,
        color: AppColors.primaryBackground,
        shadowColor: Colors.black12,
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AppPath.square
                  ),
                  repeat: ImageRepeat.repeat
                )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(500),
                    border: Border.all(
                        color:  AppColors.primary.withOpacity(0.8),
                        width: 25.0
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
