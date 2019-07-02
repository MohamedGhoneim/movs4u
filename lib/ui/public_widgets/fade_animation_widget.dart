import 'package:flutter/material.dart';

class fadeAnimationWidget extends StatefulWidget{
  Widget child;
  fadeAnimationWidget({this.child});
  @override
  _fadeAnimationWidgetState createState() => _fadeAnimationWidgetState();
}

class _fadeAnimationWidgetState extends State<fadeAnimationWidget> with TickerProviderStateMixin{


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  AnimationController animationController;
  Animation<double> animation;
  @override
  Widget build(BuildContext context) {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    animation=Tween(begin: 0.0,end: 1.0,).animate(animationController);
    animationController.forward();
    animationController.forward();

    return FadeTransition(
      child: widget.child,
      opacity: animation,
    );
  }
}
