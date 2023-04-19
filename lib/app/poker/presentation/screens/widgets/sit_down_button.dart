import 'package:alex_poker/app/poker/presentation/bloc/play/play_bloc.dart';
import 'package:alex_poker/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/widget/rounded_box.dart';
class SitDownButton extends StatelessWidget {
  const SitDownButton({
    super.key,
    required this.seatId,
    required this.amount,
    required this.roomId
  });

  final int seatId;
  final int amount;
  final String roomId;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: const Color.fromARGB(255, 38, 140, 165),
              width: 2
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: RoundedBox(
          radius: 16,
          height: 50,
          width: 50,
          child: MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              print('object');
              BlocProvider.of<PlayBloc>(context).add(PlayEventSitDown(amount: amount, seatId: seatId, tableId: roomId));
            },
            child: const Icon(Icons.add, color: AppColors.primaryWhite),
          ),
        ),
      ),
    );
  }
}