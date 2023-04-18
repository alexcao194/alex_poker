import 'package:alex_poker/config/app_colors.dart';
import 'package:alex_poker/config/app_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../config/app_fonts.dart';
import '../../../../core/services/app_router/app_router.dart';
import 'widgets/play_button.dart';
import 'widgets/player.dart';
import 'widgets/playing_background.dart';
import 'widgets/playing_card.dart';
import 'widgets/user_card.dart';
import 'widgets/drop_menu.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({Key? key}) : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {

  final Duration _distributeDuration = const Duration(milliseconds: 200);
  final List<bool> _distributed = [false, false, false, false, false, false, false, false, false, false];
  final int _distributedDelay = 50;
  final _playerCount = 5;
  final double _offsetPlayer = 30;
  bool _display = false;


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            context: AppRouter.navigatorKey.currentState!.context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColors.primaryBackground,
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Exiting the table if you are placing a bet will lose your bet, are you sure you want to exit?',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColors.primaryWhite
                    ),
                  ),
                ),
                actions: [
                  MaterialButton(
                      onPressed: () {
                        AppRouter.pop();
                      },
                      child: const Text('Cancel', style: TextStyle(color: AppColors.primaryWhite))),
                  MaterialButton(
                      onPressed: () async {
                        // BlocProvider.of<RoomBloc>(context).add(RoomEventLeave(id: id));
                        AppRouter.pop();
                        AppRouter.pop();
                      },
                      child: const Text('Ok', style: TextStyle(color: AppColors.primaryWhite)))
                ],
              );
            });
        return false;
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            children: [
              const PlayingBackground(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  PlayingCard(
                    type: TypeCard.piques,
                    value: 'A',
                    display: _display,
                  ),
                  PlayingCard(
                    type: TypeCard.carreaux,
                    value: '10',
                    display: _display,
                    isSet: true,
                  ),
                  PlayingCard(
                    type: TypeCard.coueurs,
                    value: '2',
                    display: _display,
                  ),
                  PlayingCard(
                    type: TypeCard.coueurs,
                    value: '2',
                    display: false && _display,
                  ),
                  PlayingCard(
                    type: TypeCard.coueurs,
                    value: '2',
                    display: false && _display,
                  ),
                ],
              ),
              const Positioned(
                top: 8,
                right: 8,
                child: UserCard()
              ),
              AnimatedPositioned(
                bottom: _distributed[0] ? size.height * 0.1 + _offsetPlayer : size.height * 0.5,
                left: _distributed[0] ? size.width * 0.5 : size.width * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: PlayingCard(value: '10', type: TypeCard.coueurs, display: _distributed[0], isSet: true),
              ),
              AnimatedPositioned(
                bottom: _distributed[1] ? size.height * 0.1 + _offsetPlayer : size.height * 0.5,
                left: _distributed[1] ? size.width * 0.5 - 54: size.width * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: PlayingCard(value: 'Q', type: TypeCard.coueurs, display: _distributed[1]),
              ),
              AnimatedPositioned(
                left: _distributed[2] ? size.width * 0.5 - size.height * 0.7: size.width * 0.5,
                top: _distributed[2] ? size.height * 0.5 - 10 : size.height * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: AnimatedRotation(
                  duration: _distributeDuration,
                  turns: _distributed[2] ? 0.25 : 0,
                  child: PlayingCard(value: 'hack cc', type: TypeCard.coueurs, active: false, display: _distributed[2]),
                ),
              ),
              AnimatedPositioned(
                left: _distributed[3] ? size.width * 0.5 - size.height * 0.7: size.width * 0.5,
                top: _distributed[3] ? size.height * 0.5 - 60 : size.height * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: AnimatedRotation(
                    turns: _distributed[3] ? 0.25 : 0,
                    duration: _distributeDuration,
                    child: PlayingCard(value: 'hack cc', type: TypeCard.coueurs, active: false, display: _distributed[3])
                ),
              ),
              AnimatedPositioned(
                left: _distributed[4] ? size.width * 0.5 - size.height * 0.5: size.width * 0.5,
                top: _distributed[4] ? size.height * 0.1 + 32 : size.height * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: AnimatedRotation(
                  duration: _distributeDuration,
                  turns: _distributed[4] ? 0.5 : 0,
                  child: PlayingCard(value: 'hack cc', type: TypeCard.coueurs, active: false, display: _distributed[4]),
                ),
              ),
              AnimatedPositioned(
                left: _distributed[5] ? size.width * 0.5 - size.height * 0.5 + 52: size.width * 0.5,
                top: _distributed[5] ? size.height * 0.1 + 32 : size.height * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: AnimatedRotation(
                    turns: _distributed[5] ? 0.5 : 0,
                    duration: _distributeDuration,
                    child: PlayingCard(value: 'hack cc', type: TypeCard.coueurs, active: false, display: _distributed[5])
                ),
              ),
              AnimatedPositioned(
                right: _distributed[6] ? size.width * 0.5 - size.height * 0.5 + 3: size.width * 0.5,
                top: _distributed[6] ? size.height * 0.1 + 32 : size.height * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: AnimatedRotation(
                  duration: _distributeDuration,
                  turns: _distributed[6] ? 0.5 : 0,
                  child: PlayingCard(value: 'hack cc', type: TypeCard.coueurs, active: false, display: _distributed[6]),
                ),
              ),
              AnimatedPositioned(
                right: _distributed[7] ? size.width * 0.5 - size.height * 0.5 + 55: size.width * 0.5,
                top: _distributed[7] ? size.height * 0.1 + 32 : size.height * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: AnimatedRotation(
                    turns: _distributed[7] ? 0.5 : 0,
                    duration: _distributeDuration,
                    child: PlayingCard(value: 'hack cc', type: TypeCard.coueurs, active: false, display: _distributed[7])
                ),
              ),
              AnimatedPositioned(
                right: _distributed[8] ? size.width * 0.5 - size.height * 0.7: size.width * 0.5,
                top: _distributed[8] ? size.height * 0.5 - 10 : size.height * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: AnimatedRotation(
                  duration: _distributeDuration,
                  turns: _distributed[8] ? 0.75 : 0,
                  child: PlayingCard(value: 'hack cc', type: TypeCard.coueurs, active: false, display: _distributed[8]),
                ),
              ),
              AnimatedPositioned(
                right: _distributed[9] ? size.width * 0.5 - size.height * 0.7: size.width * 0.5,
                top: _distributed[9] ? size.height * 0.5 - 60 : size.height * 0.5,
                duration: _distributeDuration,
                curve: Curves.easeOut,
                child: AnimatedRotation(
                    turns: _distributed[9] ? 0.75 : 0,
                    duration: _distributeDuration,
                    child: PlayingCard(value: 'hack cc', type: TypeCard.coueurs, active: false, display: _distributed[9])
                ),
              ),
              Positioned(
                bottom: size.height * 0.1 - _offsetPlayer,
                child: const Player(isActive: true),
              ),
              Positioned(
                left: size.width * 0.5 - size.height * 0.8 - _offsetPlayer,
                child: const Player(isActive: false),
              ),
              Positioned(
                top: size.height * 0.1 - _offsetPlayer,
                left: size.width * 0.3,
                child: const Player(isActive: false),
              ),
              Positioned(
                top: size.height * 0.1 - _offsetPlayer,
                right: size.width * 0.3,
                child: const Player(isActive: false),
              ),
              Positioned(
                right: size.width * 0.5 - size.height * 0.8 - _offsetPlayer,
                child: const Player(isActive: false),
              ),
              AnimatedPositioned(
                top: size.height * 0.32,
                  duration: _distributeDuration,
                  child: Row(
                    children: [
                      Image.asset(
                        AppPath.chip,
                        width: 25,
                        height: 25,
                      ),
                      const SizedBox(width: 8.0),
                      Text('1.45M', style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: AppColors.primaryWhite,
                          fontFamily: AppFonts.superBoom
                      ))
                    ],
                  )
              ),
              const Positioned(
                  top: 8,
                  left: 8,
                  child: DropMenu()
              ),
              const Positioned(
                bottom: 8,
                left: 8,
                child: SizedBox(
                  width: 150,
                  child: Text('Thung pha sanh'),
                ),
              ),
              Positioned(
                right: 8,
                bottom: 8,
                child: Column(
                  children: [
                    Row(
                      children: const [
                        PlayButton(playActions: PlayActions.bet),
                        PlayButton(playActions: PlayActions.foldIfRaise, active: true)
                      ],
                    ),
                    Row(
                      children: const [
                        PlayButton(playActions: PlayActions.call),
                        PlayButton(playActions: PlayActions.fold)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  @override
  void initState() {
    _distribute();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp
    ]);
    super.dispose();
  }

  void _distribute() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        for(int i = 0; i < _playerCount * 2; i++) {
          await Future.delayed(
            Duration(milliseconds: _distributedDelay),
                () {
              setState(() {
                _distributed[i] = true;
              });
            },
          );
        }
        await Future.delayed(
            Duration(milliseconds: _playerCount * 2 * _distributedDelay),
                () {
              setState(() {
                _display = true;
              });
            }
        );
      },
    );
  }
}





