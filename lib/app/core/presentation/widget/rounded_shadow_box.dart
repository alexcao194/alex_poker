import 'package:flutter/material.dart';

import '../../../../../config/app_colors.dart';
import 'rounded_box.dart';

class RoundedShadowBox extends StatelessWidget {
  const RoundedShadowBox({
    Key? key,
    required this.radius,
    this.color,
    this.spreadRadius,
    this.blurRadius,
    this.height,
    this.width,
    this.child,
    this.shadowColor
  }) : super(key: key);

  final double radius;
  final double? spreadRadius;
  final double? blurRadius;
  final double? height;
  final double? width;
  final Widget? child;
  final Color? color;
  final Color? shadowColor;

  @override
  Widget build(BuildContext context) {
    return RoundedBox(
      radius: radius,
      height: height,
      width: width,
      boxShadows: [
        BoxShadow(
          color: shadowColor ?? (color ?? Theme.of(context).primaryColor),
          spreadRadius: spreadRadius ?? 2,
          blurRadius: blurRadius ?? 20,
          offset: const Offset(0, 3), // changes position
        )
      ],
      color: color ?? Theme.of(context).primaryColor,
      child: child ?? const SizedBox(),
    );
  }
}
