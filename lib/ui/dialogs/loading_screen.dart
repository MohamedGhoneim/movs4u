import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:movs4u/utils/app_constants.dart';

import 'animations.dart';

class LoadingScreen extends StatefulWidget {
  Widget formUi;
  LoadingScreen({this.formUi});
  @override
  _LoadingScreenState createState() => new _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Tween<double> tween;

  @override
  initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    tween = new Tween<double>(begin: 0.0, end: 1.00);
    _controller.repeat().orCancel;
  }

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Animation<double> get stepOne => tween.animate(
        new CurvedAnimation(
          parent: _controller,
          curve: new Interval(
            0.0,
            0.125,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepTwo => tween.animate(
        new CurvedAnimation(
          parent: _controller,
          curve: new Interval(
            0.125,
            0.26,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepThree => tween.animate(
        new CurvedAnimation(
          parent: _controller,
          curve: new Interval(
            0.25,
            0.375,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepFour => tween.animate(
        new CurvedAnimation(
          parent: _controller,
          curve: new Interval(
            0.375,
            0.5,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepFive => tween.animate(
        new CurvedAnimation(
          parent: _controller,
          curve: new Interval(
            0.5,
            0.625,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepSix => tween.animate(
        new CurvedAnimation(
          parent: _controller,
          curve: new Interval(
            0.625,
            0.75,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepSeven => tween.animate(
        new CurvedAnimation(
          parent: _controller,
          curve: new Interval(
            0.75,
            0.875,
            curve: Curves.linear,
          ),
        ),
      );
  Animation<double> get stepEight => tween.animate(
        new CurvedAnimation(
          parent: _controller,
          curve: new Interval(
            0.875,
            1.0,
            curve: Curves.linear,
          ),
        ),
      );

  Widget get forwardStaggeredAnimation {
    return new Center(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new PivotBar(
            alignment: FractionalOffset.centerLeft,
            controller: _controller,
            animations: [
              stepOne,
              stepTwo,
            ],
            marginRight: 0.0,
            marginLeft: 0.0,
            isClockwise: true,
          ),
          new PivotBar(
            controller: _controller,
            animations: [
              stepThree,
              stepEight,
            ],
            marginRight: 0.0,
            marginLeft: 0.0,
            isClockwise: false,
          ),
          new PivotBar(
            controller: _controller,
            animations: [
              stepFour,
              stepSeven,
            ],
            marginRight: 0.0,
            marginLeft: 32.0,
            isClockwise: true,
          ),
          new PivotBar(
            controller: _controller,
            animations: [
              stepFive,
              stepSix,
            ],
            marginRight: 0.0,
            marginLeft: 32.0,
            isClockwise: false,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Stack(
        children: <Widget>[
          widget.formUi,
          forwardStaggeredAnimation
        ],
      ),
    );




    //Container(child: forwardStaggeredAnimation);
  }
}
