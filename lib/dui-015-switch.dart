import 'package:flutter/material.dart';
import 'dart:math';

const PAGE_HEIGHT = 300.0;
const PAGE_WIDTH = 300.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(body: Center(child: SwitchWidget())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SwitchWidget extends StatefulWidget {
  const SwitchWidget({
    Key key,
  }) : super(key: key);

  @override
  _SwitchWidgetState createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> with SingleTickerProviderStateMixin {
  bool _lightMode = true;
  AnimationController _controller;
  Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(-1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutCirc,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: PAGE_WIDTH,
      height: PAGE_HEIGHT,
      duration: Duration(milliseconds: 500),
      color: Colors.black,
      child: Stack(children: [
        SlideTransition(
            position: _offsetAnimation,
            child: Container(
                height: PAGE_HEIGHT,
                width: PAGE_WIDTH,
                color: Colors.white
            )
        ),
        Align(
          alignment: Alignment.center,
          child: Icon(
            Icons.location_city,
            size: 230.0,
            color: Colors.grey,
          ),
        ),
        AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            top: 30,
            right: _lightMode ? -80 : 30,
            child: Transform.rotate(
              angle: pi / 9.0,
              child: Icon(
                Icons.brightness_3,
                size: 60.0,
              ),
            )),
        AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            top: 30,
            left: _lightMode ? 30 : -90,
            child: Icon(
              Icons.wb_sunny,
              size: 60.0,
              color: Colors.orange,
            )),
        Align(
          alignment: Alignment.bottomCenter,
          child: Switch(
            value: _lightMode,
            inactiveTrackColor: Colors.grey[200],
            activeColor: Colors.orange,
            activeTrackColor: Colors.orange[300],
            onChanged: (newVal) {
              setState(() {
                _lightMode = newVal;
              });
              if (_lightMode) {
                _controller.reverse();
              } else {
                _controller.forward();
              }
            },
          ),
        ),
      ]),
    );
  }
}
