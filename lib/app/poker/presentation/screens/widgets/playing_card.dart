import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_paths.dart';
import '../../../../core/presentation/widget/rounded_shadow_box.dart';
import '../../../domain/entities/card.dart';

class PlayingCard extends StatelessWidget {
  const PlayingCard({
    Key? key,
    required this.value,
    required this.type,
    this.display,
    this.active,
    this.isSet
  }) : super(key: key);

  final String value;
  final TypeCard type;
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
              child: Text(value,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.primaryWhite
                  )
              ),
            ),
            Positioned(
              bottom: 3,
              right: 5,
              child: Image.asset(getType(type), height: 15, width: 15),
            )
          ],
        ) : null,
      ) : const SizedBox(
        height: 55,
        width: 42,
      ),
    );
  }

  String getType(TypeCard type) {
    switch(type) {
      case TypeCard.carreaux:
        return AppPath.carreaux;
      case TypeCard.coueurs:
        return AppPath.coeurs;
      case TypeCard.piques:
        return AppPath.piques;
      case TypeCard.trefles:
        return AppPath.trefles;
    }
  }
}