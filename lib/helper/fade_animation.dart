import 'package:flutter/material.dart';


class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

   const FadeAnimation(this.delay, this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child;

  }
}