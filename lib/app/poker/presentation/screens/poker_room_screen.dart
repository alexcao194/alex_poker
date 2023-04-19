import 'package:alex_poker/app/core/presentation/widget/appear_widget.dart';
import 'package:alex_poker/app/core/presentation/widget/page_controller_holder.dart';
import 'package:alex_poker/app/poker/presentation/bloc/page/page_cubit.dart';
import 'package:alex_poker/config/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../../config/app_colors.dart';
import '../../../../config/app_fonts.dart';
import '../../../core/presentation/widget/custom_app_bar.dart';
import '../../../home/presentation/bloc/user_profile_bloc.dart';
import '../../domain/entities/room.dart';
import '../bloc/room/room_bloc.dart';

class PokerRoom extends StatefulWidget {
  const PokerRoom({Key? key}) : super(key: key);

  @override
  State<PokerRoom> createState() => _PokerRoomState();
}

class _PokerRoomState extends State<PokerRoom> {
  late PageController pageController;
  final List<Color> _colorModes = [AppColors.cyan, AppColors.deepSkyBlue, Colors.orange, Colors.purple];
  final List<String> _playerState = [
    AppPath.playerStatus0,
    AppPath.playerStatus1,
    AppPath.playerStatus2,
    AppPath.playerStatus3,
    AppPath.playerStatus4,
    AppPath.playerStatus5
  ];

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle navTextStyle = Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.primaryWhite, fontWeight: FontWeight.bold, fontFamily: AppFonts.blomberg);
    return WillPopScope(
      onWillPop: () {
        BlocProvider.of<RoomBloc>(context).add(RoomEventDisConnect());
        return Future.value(true);
      },
      child: BlocBuilder<RoomBloc, RoomState>(
        builder: (context, roomState) {
          var chip = (BlocProvider.of<UserProfileBloc>(context).state as UserProfileStateGetSuccessful).user.chipAmount;
          return SafeArea(
            child: PageControllerHolder(
              pageController: pageController,
              child: Scaffold(
                backgroundColor: AppColors.primary,
                appBar: CustomAppBar(context: context, chip: chip),
                bottomNavigationBar: buildGNav(navTextStyle),
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 24.0,
                      width: double.maxFinite,
                    ),
                    Text('Poker Rooms', style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: AppColors.primaryWhite, fontFamily: AppFonts.superBoom)),
                    Expanded(child: Builder(
                      builder: (context) {
                        if (roomState is RoomStateLoading) {
                          return Center(
                            child: Text('Loading...', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: AppFonts.blomberg, color: AppColors.primaryWhite)),
                          );
                        } else if (roomState is RoomStateGetFail) {
                          return Center(
                            child: Text(roomState.error),
                          );
                        } else if (roomState is RoomStateGetSuccessful) {
                          return buildListRoom(context, roomState.listRoom);
                        }
                        return const Center(
                          child: Text('internal error'),
                        );
                      },
                    ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  PageView buildListRoom(BuildContext context, List<Room> rooms) {
    return PageView.builder(
      itemCount: 4,
      controller: pageController,
      onPageChanged: (position) {
        context.read<PageCubit>().change(RoomPage.values[position]);
      },
      itemBuilder: (context, page) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: rooms.length,
              itemBuilder: (BuildContext context, int index) {
                var room = rooms[index];
                return AppearAnimation(
                  startAlign: Alignment.centerLeft,
                  endAlign: Alignment.center,
                  delay: Duration(milliseconds: 100 * index),
                  duration: const Duration(milliseconds: 500),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(color: _colorModes[page], borderRadius: BorderRadius.circular(15.0)),
                            child: MaterialButton(
                                onPressed: () {
                                    _join(room.id);
                                },
                                padding: EdgeInsets.zero,
                                child: Center(child: Image.asset(_playerState[room.currentNumberPlayers]))),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${room.smallBlind}/${room.bigBlind}',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontFamily: AppFonts.superBoom, color: AppColors.primaryWhite),
                        ),
                        Text(
                          room.name,
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: AppFonts.superBoom, color: AppColors.primaryWhite),
                        )
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );
  }

  Widget buildGNav(TextStyle navTextStyle) {
    return BlocBuilder<PageCubit, RoomPage>(
      builder: (context, page) {
        return GNav(
            backgroundColor: AppColors.primaryBackground,
            rippleColor: Colors.grey,
            tabBorderRadius: 30,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            color: AppColors.primaryWhite,
            activeColor: AppColors.cyan,
            selectedIndex: RoomPage.values.indexOf(page),
            gap: 8,
            onTabChange: (tab) {
              context.read<PageCubit>().change(RoomPage.values[tab], controller: pageController);
            },
            tabs: [
              GButton(
                icon: Icons.people,
                text: RoomPage.normal.name,
                textStyle: navTextStyle,
                borderRadius: BorderRadius.circular(15),
              ),
              GButton(
                icon: Icons.bar_chart,
                text: RoomPage.rank.name,
                textStyle: navTextStyle,
                borderRadius: BorderRadius.circular(15),
              ),
              GButton(
                icon: Icons.account_balance_wallet,
                text: RoomPage.vip1.name,
                textStyle: navTextStyle,
                borderRadius: BorderRadius.circular(15),
              ),
              GButton(
                icon: Icons.wallet_sharp,
                textStyle: navTextStyle,
                text: RoomPage.vip2.name,
                borderRadius: BorderRadius.circular(15),
              )
            ]);
      },
    );
  }

  void _join(String id) {
    BlocProvider.of<RoomBloc>(context).add(RoomEventJoin(id: id));
  }
}
