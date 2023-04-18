import 'package:flutter/material.dart';

import '../../../../../config/app_paths.dart';
import '../../../../core/presentation/widget/rounded_box.dart';

class Player extends StatelessWidget {
  const Player({
    Key? key,
    required this.isActive
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
              color: isActive ? const Color.fromARGB(255, 38, 140, 165) : Colors.transparent,
              width: 2
          )
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.5),
        child: RoundedBox(
          radius: 16,
          height: 50,
          width: 50,
          child: Image.asset(AppPath.asset_1, fit: BoxFit.cover),
        ),
      ),
    );
  }
}