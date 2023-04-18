import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import '../../../../../config/app_paths.dart';
import '../../../../core/presentation/widget/rounded_box.dart';
import '../../../../core/presentation/widget/rounded_shadow_box.dart';


class EventCard extends StatelessWidget {
  const EventCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:  Stack(
        children: [
          RoundedShadowBox(
            radius: 30,
            height: size.width * 0.3,
            color: AppColors.primaryBackground,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () {

              },
              child: Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    RoundedBox(
                        radius: 20.0,
                        height: size.width * 0.22,
                        width: size.width * 0.16,
                        boxShadows: const [
                          BoxShadow(
                            color: AppColors.primary,
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3), // changes position
                          )
                        ],
                        child: Image.asset(AppPath.asset_1, fit: BoxFit.cover)
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Upcoming Event',
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                  overflow: TextOverflow.ellipsis,
                                  color: AppColors.primaryWhite,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                          Text(
                              'Promotion Bounder',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                  color: AppColors.subWhite,
                                  fontWeight: FontWeight.w600
                              )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 45.0)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: AppColors.subWhite,
                )
            ),
          )

        ],
      ),
    );
  }
}