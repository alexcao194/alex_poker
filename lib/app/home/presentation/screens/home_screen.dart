import 'package:alex_poker/app/core/presentation/widget/custom_app_bar.dart';
import 'package:alex_poker/app/home/presentation/bloc/user_profile_bloc.dart';
import 'package:alex_poker/app/poker/presentation/bloc/play/play_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_paths.dart';
import '../../../core/presentation/widget/appear_widget.dart';
import '../../../core/presentation/widget/rounded_box.dart';
import '../../../poker/presentation/bloc/room/room_bloc.dart';
import 'widgets/event_card.dart';
import 'widgets/mode_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var chip = (BlocProvider.of<UserProfileBloc>(context).state as UserProfileStateGetSuccessful).user.chipAmount;
    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: CustomAppBar(context: context, chip: chip),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            AppearAnimation(
              duration: const Duration(milliseconds: 1500),
              startAlign: Alignment.topCenter,
              endAlign: Alignment.center,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RoundedBox(
                        radius: 20.0,
                        height: size.width * 0.3,
                        width: size.width * 0.16,
                        boxShadows: const [
                          BoxShadow(
                            color: AppColors.primaryBackground,
                            spreadRadius: 2,
                            blurRadius: 20,
                            offset: Offset(0, 3), // changes position
                          )
                        ],
                        child: Image.asset(AppPath.asset_1, fit: BoxFit.cover)),
                  ),
                  const Expanded(
                    child: EventCard(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'Lobby',
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: AppColors.primaryWhite,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            SizedBox(
              height: 800,
              child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
                itemBuilder: (context, index) {
                  return AppearAnimation(
                    duration: const Duration(milliseconds: 700),
                    endAlign: Alignment.center,
                    startAlign: Alignment.centerLeft,
                    delay: Duration(milliseconds: 200 * index),
                    child: ModeItem(
                      onPress: () {
                        _startPoker(context);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        ),
      )),
    );
  }

  void _startPoker(BuildContext context) {
    BlocProvider.of<RoomBloc>(context).add(RoomEventConnect());
    BlocProvider.of<PlayBloc>(context).add(PlayEventConnect());
  }
}


