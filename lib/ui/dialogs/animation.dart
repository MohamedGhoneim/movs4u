import 'package:flutter/material.dart';
import 'package:movs4u/utils/app_constants.dart';
import 'dart:math';

class animation extends StatefulWidget {
  Widget formUi;

  animation({this.formUi});

  @override
  _animationState createState() => _animationState();
}

class _animationState extends State<animation> with TickerProviderStateMixin {
  Animation<double> catAnimation;
  AnimationController catController;
  Animation<double> boxAnimation;
  AnimationController boxController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    boxController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    boxAnimation = Tween(begin: pi * 0.6, end: pi * 0.65).animate(
      CurvedAnimation(parent: boxController, curve: Curves.easeInOut),
    );
    boxAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        boxController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        boxController.forward();
      }
    });
    boxController.forward();
    catController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
    catAnimation = Tween(begin: -35.0, end: -30.0)
        .animate(CurvedAnimation(parent: catController, curve: Curves.easeIn));

  }

  onTap() {
    if (catController.status == AnimationStatus.completed) {
      catController.reverse();
      boxController.forward();
    } else if (catController.status == AnimationStatus.dismissed) {
      catController.forward();
      boxController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          widget.formUi,
          GestureDetector(
            child: Center(
              child: Stack(
                overflow: Overflow.visible,
                children: <Widget>[
                  buildCatAnimation(), // appear at bottom of stack
                  buildBox(),
                  buildLeftFlap(), // appear at top of stack
                  buildRightFlap(), // appear at top of stack
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCatAnimation() {
    return AnimatedBuilder(
      animation: catAnimation,
      builder: (context, child) {
        return Positioned(
          child: child,
          top: catAnimation.value,
          right: 0.0,
          left: 0.0,
        );
      },
      child: Image.asset('images/register.png'),
    );
  }

  Widget buildBox() {
    return Container(
      height: 50.0,
      width: 50.0,
      color: AppConstants.buttonColor,
    );
  }

  Widget buildLeftFlap() {
    return Positioned(
      left: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 35.0,
          color: AppConstants.buttonColor,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topLeft,
            angle: boxAnimation.value,
          );
        },
      ),
    );
  }

  Widget buildRightFlap() {
    return Positioned(
      right: 3.0,
      child: AnimatedBuilder(
        animation: boxAnimation,
        child: Container(
          height: 10.0,
          width: 35.0,
          color: AppConstants.buttonColor,
        ),
        builder: (context, child) {
          return Transform.rotate(
            child: child,
            alignment: Alignment.topRight,
            angle: -boxAnimation.value,
          );
        },
      ),
    );
  }
}
