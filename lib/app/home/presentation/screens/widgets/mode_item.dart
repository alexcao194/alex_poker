import 'package:alex_poker/config/app_paths.dart';
import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../core/presentation/widget/rounded_shadow_box.dart';

class ModeItem extends StatefulWidget {
  const ModeItem({
    Key? key,
    required this.onPress
  }) : super(key: key);

  final VoidCallback onPress;

  @override
  State<ModeItem> createState() => _ModeItemState();
}

class _ModeItemState extends State<ModeItem> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: RoundedShadowBox(
          radius: 30,
          height: size.width * 0.25,
          width: size.width * 0.85,
          color: AppColors.primaryBackground,
        child: MaterialButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            widget.onPress();
          },
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: RoundedShadowBox(
                    radius: 20,
                    height: double.maxFinite,
                    color: AppColors.primary,
                  child: Image.asset(AppPath.asset_1, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Devola\'s Club',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.primaryWhite,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    Text('Let\'s go fishing',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: AppColors.subWhite,
                      ),
                    ),
                    Row(
                      children: [
                        Text('15/300',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: AppColors.subWhite,
                          )
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.people, color: AppColors.subWhite, size: 18)
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Play',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.primaryWhite,
                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}