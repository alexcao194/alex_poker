import 'package:alex_poker/config/app_colors.dart';
import 'package:flutter/material.dart';

class RoundedBox extends StatelessWidget {
  const RoundedBox({
    Key? key,
    required this.child,
    this.radius,
    this.width,
    this.height,
    this.color,
    this.boxShadows
  }) : super(key: key);

  final Widget child;
  final double? radius;
  final double? height;
  final double? width;
  final Color? color;
  final List<BoxShadow>? boxShadows;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: radius != null ? BorderRadius.circular(radius!) : null,
        color: color,
        boxShadow: boxShadows
      ),
      child: ClipRRect(
        borderRadius: radius != null ? BorderRadius.circular(radius!) : null,
        child: child,
      ),
    );
  }
}
