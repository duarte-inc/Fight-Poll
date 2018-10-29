import 'package:flutter/material.dart';

class SizeAnimation extends StatefulWidget {
  final Widget child;
  SizeAnimation({this.child});

  @override
  _SizeAnimationState createState() => _SizeAnimationState();
}

class _SizeAnimationState extends State<SizeAnimation>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _widthAnimation;

  @override
  void initState() {
    super.initState();

    this._animationController =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              print("done");
            }
            setState(() {});
          });

    this._widthAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    this._animationController.forward();
  }

  @override
  void didUpdateWidget(SizeAnimation oldWidget) {
    super.didUpdateWidget(oldWidget);

    this._animationController =
        AnimationController(duration: Duration(milliseconds: 1000), vsync: this)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {}
            setState(() {});
          });

    this._widthAnimation = this._widthAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    this._animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    this._animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      height: 10.0,
      child: SizeTransition(
        axis: Axis.horizontal,
        sizeFactor: _widthAnimation,
        axisAlignment: 0.0,
        child: widget.child,
      ),
    );
  }
}