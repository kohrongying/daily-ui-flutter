import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() => runApp(MyApp());

const PAGE_HEIGHT = 500.0;
const PAGE_WIDTH = 800.0;

class CustomButton extends StatelessWidget {
  final String btnText;
  CustomButton({this.btnText});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(color: Theme.of(context).primaryColor)
      ),
      color: Colors.transparent,
      hoverColor: Colors.blueGrey,
      child: Text(btnText),
      onPressed: () {
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Sign up success!')));
      },
    );
  }
}

class LandingPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: PAGE_WIDTH * 0.8,
            height: PAGE_HEIGHT * 0.75,
            color: Colors.green,
            child: Image.network(
                "https://images.unsplash.com/photo-1500215238115-1322078d92a3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80",
                fit: BoxFit.cover),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: PAGE_WIDTH * 0.8,
            padding:
            const EdgeInsets.symmetric(horizontal: 60.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    "We are not limitless.",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                Text("Start living responsibly.",
                    style: Theme.of(context).textTheme.headline1),
                Padding(
                  padding: const EdgeInsets.only(top: 44.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Our Story → ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Text("Leaf us a message → ",
                          style: Theme.of(context).textTheme.bodyText1),
                      CustomButton(btnText: "Bring Nature Back")
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40.0, right: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    btnText: "f",
                  ),
                  CustomButton(
                    btnText: "i",
                  ),
                  CustomButton(
                    btnText: "t",
                  )
                ],
              ),
            ))
      ],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.white,
          accentColor: Colors.black,
          textTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 72,
                  fontWeight: FontWeight.w700,
                  height: 1.15,
                  color: Colors.white.withOpacity(1.0)),
              bodyText1: TextStyle(fontSize: 16)),
          buttonTheme: ButtonThemeData(
            minWidth: 8.0,
          )),
      home: Scaffold(
          body: Center(
              child: AnimatedBgWidget())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnimatedBgWidget extends StatefulWidget {
  @override
  _AnimatedBgWidgetState createState() => _AnimatedBgWidgetState();
}

class _AnimatedBgWidgetState extends State<AnimatedBgWidget> {
  Color _color1 = Colors.black;
  Color _color2 = Colors.black;
  Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      setState(() {
        final random = Random();
        _color1 = Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          1,
        );

        _color2 = Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          1,
        );
      });
    });
    super.initState();
  }


  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: Duration(milliseconds: 1500,),
        decoration: new BoxDecoration(
          color: Colors.black,
          gradient: new LinearGradient(
              colors: [_color1, _color2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
          ),
        ),
        width: PAGE_WIDTH,
        height: PAGE_HEIGHT,
        child: LandingPageWidget()
    );
  }
}
