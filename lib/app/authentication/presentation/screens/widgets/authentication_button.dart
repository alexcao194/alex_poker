import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  const AuthenticationButton({
    Key? key,
    required this.child,
    this.width,
    this.onTap
  }) : super(key: key);

  final double? width;
  final VoidCallback? onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: width ?? double.maxFinite,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.0)
        ),
        child: Center(
            child: child
        ),
      ),
    );
  }
}