import 'package:flutter/material.dart';

class AppearAnimation extends StatefulWidget {
  const AppearAnimation({
    Key? key,
    required this.child,
    this.delay,
    required this.startAlign,
    required this.endAlign,
    required this.duration
  }) : super(key: key);
  final Duration? delay;
  final Widget child;
  final Alignment startAlign;
  final Alignment endAlign;
  final Duration duration;
  @override
  State<AppearAnimation> createState() => _AppearAnimationState();
}

class _AppearAnimationState extends State<AppearAnimation> {
  bool _done = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _done ? 1 : 0,
      duration: widget.duration,
      curve: Curves.easeOut,
      child: AnimatedContainer(
          duration: widget.duration,
          curve: Curves.easeOut,
          alignment: _done ? widget.endAlign : widget.startAlign,
          child: widget.child
      ),
    );
  }

  @override
  void initState() {
    startAnimation();
    super.initState();
  }


  @override
  void dispose() {
    _done = false;
    super.dispose();
  }

  void startAnimation() async {
    await Future.delayed(widget.delay ?? const Duration(milliseconds: 100)).then((value) {
      if(mounted) {
        setState(() {
          _done = true;
        });
      }
    });
  }
}
