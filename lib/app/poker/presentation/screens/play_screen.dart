import 'package:alex_poker/app/home/presentation/bloc/user_profile_bloc.dart';
import 'package:alex_poker/app/poker/domain/entities/seat.dart';
import 'package:alex_poker/config/app_colors.dart';
import 'package:alex_poker/config/app_paths.dart';
import 'package:alex_poker/core/notification/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/app_fonts.dart';
import '../../../../core/services/app_router/app_router.dart';
import '../../../core/presentation/widget/rounded_shadow_box.dart';
import '../../domain/entities/card.dart';
import '../bloc/play/play_bloc.dart';
import 'widgets/play_button.dart';
import 'widgets/player.dart';
import 'widgets/playing_background.dart';
import 'widgets/playing_card.dart';
import 'widgets/sit_down_button.dart';
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
  int _maxBet = 0;
  late final List<String> _messages = [];
  final double _offsetPlayer = 30;
  bool _isEnd = true;
  bool _display = false;
  int _currentSeat = 0;
  late ScrollController _scrollController;
  final Map<int, Seat?> _appSeats = {
    1 : null,
    2 : null,
    3 : null,
    4 : null,
    5 : null
  };

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocBuilder<UserProfileBloc, UserProfileState>(
      builder: (context, userState) {
        return BlocBuilder<PlayBloc, PlayState>(
          builder: (context, playState) {
            if (playState is PlayStatePlaying) {
              _getSeats(playState, userState as UserProfileStateGetSuccessful);
              _newHand(playState);
              _messageUpdate(playState);
              _updateBet(playState);
              return WillPopScope(
                onWillPop: () async {
                  AppNotification.showAlertDialog(
                      message: 'Exiting the table if you are placing a bet will lose your bet, are you sure you want to exit?',
                      onAccept: () {
                        BlocProvider.of<PlayBloc>(context).add(PlayEventLeave(roomId: playState.room.id));
                        AppRouter.pop();
                      },
                      onCancel: () {});
                  return false;
                },
                child: Scaffold(
                  backgroundColor: AppColors.primary,
                  body: SafeArea(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if(_messages.isNotEmpty) Positioned(
                          bottom: 8,
                          left: 8,
                          child: RoundedShadowBox(
                            radius: 10.0,
                            height: size.height * 0.1,
                            width: size.width * 0.2,
                            blurRadius: 5,
                            spreadRadius: 0,
                            color: AppColors.primaryBackground,
                            child: ListView.builder(
                              controller: _scrollController,
                              itemCount: _messages.length,
                              itemBuilder: (context, index) {
                                return Text(_messages[index], style: Theme.of(context).textTheme.labelSmall!.copyWith(
                                  color: AppColors.primaryWhite
                                ));
                              },
                            ),
                          ),
                        ),
                        const PlayingBackground(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PlayingCard(
                              suit: playState.room.board.isNotEmpty ? playState.room.board[0].suit : Suit.carreaux,
                              rank: playState.room.board.isNotEmpty ? playState.room.board[0].rank : "Hack cc",
                              display: _display && playState.room.board.isNotEmpty,
                            ),
                            PlayingCard(
                              suit: playState.room.board.length >= 2 ? playState.room.board[1].suit : Suit.carreaux,
                              rank: playState.room.board.length >= 2 ? playState.room.board[1].rank : "Hack cc",
                              display: _display && playState.room.board.length >= 2,
                              isSet: true,
                            ),
                            PlayingCard(
                              suit: playState.room.board.length >= 3 ? playState.room.board[2].suit : Suit.carreaux,
                              rank: playState.room.board.length >= 3 ? playState.room.board[2].rank : "Hack cc",
                              display: _display && playState.room.board.length >= 3,
                            ),
                            PlayingCard(
                              suit: playState.room.board.length >= 4 ? playState.room.board[3].suit : Suit.carreaux,
                              rank: playState.room.board.length >= 4 ? playState.room.board[3].rank : "Hack cc",
                              display: _display && playState.room.board.length >= 4,
                            ),
                            PlayingCard(
                              suit: playState.room.board.length >= 5 ? playState.room.board[4].suit : Suit.carreaux,
                              rank: playState.room.board.length >= 5 ? playState.room.board[4].rank : "Hack cc",
                              display: _display && playState.room.board.length >= 5,
                            ),
                          ],
                        ),
                        const Positioned(top: 8, right: 8, child: UserCard()),

                        AnimatedPositioned(
                          bottom: _distributed[0] ? size.height * 0.1 + _offsetPlayer : size.height * 0.5,
                          left: _distributed[0] ? size.width * 0.5 : size.width * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: buildCard(0, _appSeats[1], 0)
                        ),
                        AnimatedPositioned(
                          bottom: _distributed[1] ? size.height * 0.1 + _offsetPlayer : size.height * 0.5,
                          left: _distributed[1] ? size.width * 0.5 - 54 : size.width * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: buildCard(1, _appSeats[1], 1)
                        ),
                        AnimatedPositioned(
                          left: _distributed[2] ? size.width * 0.5 - size.height * 0.7 : size.width * 0.5,
                          top: _distributed[2] ? size.height * 0.5 - 10 : size.height * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: AnimatedRotation(
                            duration: _distributeDuration,
                            turns: _distributed[2] ? 0.25 : 0,
                            child: buildCard(0, _appSeats[5], 2)
                          ),
                        ),
                        AnimatedPositioned(
                          left: _distributed[3] ? size.width * 0.5 - size.height * 0.7 : size.width * 0.5,
                          top: _distributed[3] ? size.height * 0.5 - 60 : size.height * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: AnimatedRotation(
                            turns: _distributed[3] ? 0.25 : 0,
                            duration: _distributeDuration,
                            child: buildCard(1, _appSeats[5], 3)
                          ),
                        ),
                        AnimatedPositioned(
                          left: _distributed[4] ? size.width * 0.5 - size.height * 0.5 + 70 : size.width * 0.5,
                          top: _distributed[4] ? size.height * 0.1 + 32 : size.height * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: AnimatedRotation(
                            duration: _distributeDuration,
                            turns: _distributed[4] ? 0.5 : 0,
                            child: buildCard(0, _appSeats[4], 4)
                          ),
                        ),
                        AnimatedPositioned(
                          left: _distributed[5] ? size.width * 0.5 - size.height * 0.5 + 120 : size.width * 0.5,
                          top: _distributed[5] ? size.height * 0.1 + 32 : size.height * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: AnimatedRotation(
                            turns: _distributed[5] ? 0.5 : 0,
                            duration: _distributeDuration,
                            child: buildCard(1, _appSeats[4], 5)
                          ),
                        ),
                        AnimatedPositioned(
                          right: _distributed[6] ? size.width * 0.5 - size.height * 0.5 + 62 : size.width * 0.5,
                          top: _distributed[6] ? size.height * 0.1 + 32 : size.height * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: AnimatedRotation(
                            duration: _distributeDuration,
                            turns: _distributed[6] ? 0.5 : 0,
                            child: buildCard(0, _appSeats[3], 6)
                          ),
                        ),
                        AnimatedPositioned(
                          right: _distributed[7] ? size.width * 0.5 - size.height * 0.5 + 112 : size.width * 0.5,
                          top: _distributed[7] ? size.height * 0.1 + 32 : size.height * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: AnimatedRotation(
                            turns: _distributed[7] ? 0.5 : 0,
                            duration: _distributeDuration,
                            child: buildCard(1, _appSeats[3], 7)
                          ),
                        ),
                        AnimatedPositioned(
                          right: _distributed[8] ? size.width * 0.5 - size.height * 0.7 : size.width * 0.5,
                          top: _distributed[8] ? size.height * 0.5 - 10 : size.height * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: AnimatedRotation(
                            duration: _distributeDuration,
                            turns: _distributed[8] ? 0.75 : 0,
                            child: buildCard(0, _appSeats[2], 8)
                          ),
                        ),
                        AnimatedPositioned(
                          right: _distributed[9] ? size.width * 0.5 - size.height * 0.7 : size.width * 0.5,
                          top: _distributed[9] ? size.height * 0.5 - 60 : size.height * 0.5,
                          duration: _distributeDuration,
                          curve: Curves.easeOut,
                          child: AnimatedRotation(
                            turns: _distributed[9] ? 0.75 : 0,
                            duration: _distributeDuration,
                            child: buildCard(1, _appSeats[2], 9)
                          ),
                        ),
                        Positioned(
                          bottom: size.height * 0.1 - _offsetPlayer,
                          child: buildPlayer(playState, userState, 1),
                        ),
                        Positioned(
                          top: size.height * 0.1 - _offsetPlayer,
                          left: size.width * 0.3,
                          child: buildPlayer(playState, userState, 4),
                        ),
                        Positioned(
                          top: size.height * 0.1 - _offsetPlayer,
                          right: size.width * 0.3,
                          child: buildPlayer(playState, userState, 3),
                        ),
                        Positioned(
                          left: size.width * 0.8 + _offsetPlayer,
                          child: buildPlayer(playState, userState, 2),
                        ),
                        Positioned(
                          right: size.width * 0.8 + _offsetPlayer,
                          child: buildPlayer(playState, userState, 5),
                        ),
                        if(!playState.room.handOver) AnimatedPositioned(
                            top: size.height * 0.30,
                            duration: _distributeDuration,
                            child: Row(
                              children: [
                                Image.asset(
                                  AppPath.chip,
                                  width: 25,
                                  height: 25,
                                ),
                                const SizedBox(width: 8.0),
                                Text(playState.room.pot.toString(), style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.primaryWhite, fontFamily: AppFonts.superBoom))
                              ],
                            )),
                        const Positioned(top: 8, left: 8, child: DropMenu()),
                        if(_appSeats[1] != null && _appSeats[1]!.turn) Positioned(
                          right: 8,
                          bottom: 8,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  PlayButton(playActions: PlayActions.raise, active: (_appSeats[1]!.bet < _appSeats[1]!.stack)),
                                  PlayButton(playActions: PlayActions.check, active: (_maxBet == _appSeats[1]!.bet))
                                ],
                              ),
                              Row(
                                children: [
                                  PlayButton(playActions: PlayActions.call, active: (_maxBet > _appSeats[1]!.bet)),
                                  PlayButton(playActions: PlayActions.fold, active: (_maxBet > _appSeats[1]!.bet))
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
            } else {
              return Center(
                child: Text('Loading...', style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontFamily: AppFonts.blomberg, color: AppColors.primaryWhite)),
              );
            }
          },
        );
      },
    );
  }

  void _getSeats(PlayStatePlaying playState, UserProfileStateGetSuccessful userState) {
    Map<int, Seat?> seats = playState.room.seats;
    for (int i = 1; i <= 5; i++) {
      if (seats[i] != null && seats[i]!.player.name == userState.user.username) {
        _currentSeat = i;
      }
    }
    _appSeats[1] = seats[_currentSeat];
    _appSeats[2] = seats[(_currentSeat % 5) + 1];
    _appSeats[3] = seats[((_currentSeat + 1) % 5) + 1];
    _appSeats[4] = seats[((_currentSeat + 2) % 5) + 1];
    _appSeats[5] = seats[((_currentSeat + 3) % 5) + 1];
  }

  Widget buildPlayer(PlayStatePlaying playState, UserProfileStateGetSuccessful userState, int index) {
    bool isSitting = false;
    Map<int, Seat?> seats = playState.room.seats;
    for (int i = 1; i <= 5; i++) {
      if (seats[i] != null && seats[i]!.player.name == userState.user.username) {
        isSitting = true;
        _currentSeat = i;
      }
    }
    LabelOriented labelOriented = index >= 4 ? LabelOriented.left : LabelOriented.right;
    if (isSitting) {
      if(index == 1) {
        return Player(isActive: _appSeats[1]!.turn, name: userState.user.username, pot: _appSeats[1]!.stack, oriented: labelOriented, bet: _appSeats[1]!.bet);
      } else {
        return _appSeats[index] != null ? Player(isActive: _appSeats[index]!.turn, name: _appSeats[index]!.player.name, pot: _appSeats[index]!.stack, oriented: labelOriented, bet: _appSeats[index]!.bet) : const SizedBox();
      }
    } else {
      return playState.room.seats[index] != null
          ? Player(isActive: playState.room.seats[index]!.turn, name: playState.room.seats[index]!.player.name, pot: playState.room.seats[index]!.stack, oriented: labelOriented, bet: playState.room.seats[index]!.bet)
          : SitDownButton(
              seatId: index,
              amount: 10000,
              roomId: playState.room.id,
            );
    }
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    _scrollController.dispose();
    super.dispose();
  }

  void _distribute() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        for (int i = 0; i < _playerCount * 2; i++) {
          await Future.delayed(
            Duration(milliseconds: _distributedDelay),
            () {
              setState(() {
                _distributed[i] = true;
              });
            },
          );
        }
        await Future.delayed(Duration(milliseconds: _playerCount * 2 * _distributedDelay), () {
          if(mounted) {
            setState(() {
              _display = true;
            });
          }
        });
      },
    );
  }

  void _pull() async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      () async {
        for (int i = 0; i < _playerCount * 2; i++) {
          await Future.delayed(
            Duration(milliseconds: _distributedDelay),
            () {
              if (mounted) {
                setState(() {
                  _distributed[i] = false;
                });
              }
            },
          );
        }
        await Future.delayed(Duration(milliseconds: _playerCount * 2 * _distributedDelay), () {
          if(mounted) {
            setState(() {
              _display = false;
            });
          }
        });
      },
    );
  }

  Widget buildCard(int pos, Seat? seat, int index) {
    if(seat != null && seat.hand.isNotEmpty) {
      return PlayingCard(
          rank: seat.hand[pos].rank,
          suit: seat.hand[pos].suit,
          display: _distributed[index],
      );
    } else if(seat != null) {
      return PlayingCard(
          rank: 'Hack cc',
          suit: Suit.trefles,
          active: false,
          display: _distributed[index],
      );
    } else {
      return const SizedBox();
    }
  }

  void _newHand(PlayStatePlaying playState) {
    if (playState.room.handOver == true) {
      _isEnd = true;
      _pull();
    } else {
      if (_isEnd) {
        _isEnd = false;
        _distribute();
      }
    }
  }

  void _messageUpdate(PlayStatePlaying playState) {
    if(playState.room.message.isNotEmpty && (_messages.isEmpty || playState.room.message != _messages.last)) {
      _messages.add(playState.room.message);
      if(_scrollController.positions.isNotEmpty) {
        _scrollController.animateTo(
            _scrollController.position.maxScrollExtent + (_scrollController.position.maxScrollExtent / _scrollController.positions.length),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeOut);
      }
    }
  }

  void _updateBet(PlayStatePlaying playState) {
    _maxBet = 0;
    for(int i = 1; i <= 5; i++) {
      if(playState.room.seats[i] != null && playState.room.seats[i]!.bet > _maxBet) {
        _maxBet = playState.room.seats[i]!.bet;
      }
    }
  }
}
