import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_paths.dart';
import '../../../../core/presentation/widget/rounded_shadow_box.dart';
import '../../../domain/entities/card.dart';

class PlayingCard extends StatelessWidget {
  const PlayingCard({
    Key? key,
    required this.rank,
    required this.suit,
    this.display,
    this.active,
    this.isSet
  }) : super(key: key);

  final String rank;
  final Suit suit;
  final bool? display;
  final bool? active;
  final bool? isSet;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (display == true || display == null) ? RoundedShadowBox(
        radius: 12.0,
        height: 55.0,
        width: 42.0,
        spreadRadius: 1,
        blurRadius: 5,
        color: (isSet == true) ? AppColors.primary : AppColors.primaryBackground,
        shadowColor: AppColors.primary,
        child: (active == true || active == null) ? Stack(
          children: [
            Positioned(
              top: 1,
              left: 5,
              child: Text(rank,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.primaryWhite
                  )
              ),
            ),
            Positioned(
              bottom: 3,
              right: 5,
              child: Image.asset(getType(suit), height: 15, width: 15),
            )
          ],
        ) : null,
      ) : const SizedBox(
        height: 55,
        width: 42,
      ),
    );
  }

  String getType(Suit type) {
    switch(type) {
      case Suit.carreaux:
        return AppPath.carreaux;
      case Suit.coueurs:
        return AppPath.coeurs;
      case Suit.piques:
        return AppPath.piques;
      case Suit.trefles:
        return AppPath.trefles;
    }
  }
}