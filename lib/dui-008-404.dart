// Image credit from https://unsplash.com/photos/azyQ0Zd8zaI

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

const PAGE_HEIGHT = 600.0;
const PAGE_WIDTH = 350.0;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
          body: NotFoundPage()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NotFoundPage extends StatefulWidget {
  @override
  _NotFoundPageState createState() => _NotFoundPageState();
}

class _NotFoundPageState extends State<NotFoundPage> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  Animation _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    ); //..repeat(reverse: true);

    _fadeAnimation = Tween(
        begin: 0.0,
        end: 1.0
    ).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    return Center(
      child: Container(
        color: Colors.grey[800],
        width: PAGE_WIDTH,
        height: PAGE_HEIGHT,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network("https://images.unsplash.com/photo-1470847355775-e0e3c35a9a2c?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=701&q=80", fit: BoxFit.cover),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text("404.", style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w700),)),
                FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text("Not all who wander", style: TextStyle(fontWeight: FontWeight.w100),)),
                FadeTransition(
                    opacity: _fadeAnimation,
                    child: Text("are lost", style: TextStyle(fontWeight: FontWeight.w100),))
              ],
            ),

          ],
        ),
      ),
    );
  }
}