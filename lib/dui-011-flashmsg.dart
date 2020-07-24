import 'package:flutter/material.dart';

const PAGE_HEIGHT = 600.0;
const PAGE_WIDTH = 350.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Center(child: ArticleWidget()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ArticleWidget extends StatefulWidget {
  @override
  _ArticleWidgetState createState() => _ArticleWidgetState();
}

class _ArticleWidgetState extends State<ArticleWidget> {
  int _count = 1; // to force animated switcher to re-render
  bool _showShareButtons = false;
  Icon _shareIcon;

  final double _shareButtonX = 20;
  final double _shareButtonY = 20;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: PAGE_WIDTH,
        height: PAGE_HEIGHT,
        child: Scaffold(
            body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.green,
                child: Text("YAY"),
                onPressed: () {
                  showDialog(
                      context: context,
                      child: Dialog(
                        backgroundColor: Colors.green[300],
                        child: SuccessModal(),
                      ));
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text("NAY"),
                onPressed: () {
                  showDialog(
                      context: context,
                      child: Dialog(
                        backgroundColor: Colors.red,
                        child: FailureModal(),
                      ));
                },
              ),
            ],
          ),
        )));
  }
}

class SuccessModal extends StatelessWidget {
  const SuccessModal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PAGE_HEIGHT * 0.6,
      width: PAGE_WIDTH * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  child: Icon(
                    Icons.done,
                    color: Colors.green[300],
                    size: 50.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 10.0),
                  child: Text("SUCCESS",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  child: Text(
                    "You survived another day! You can do it again tomorrow!",
                    style:
                        TextStyle(fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox.expand(
              child: FlatButton(
                color: Colors.green,
                child: Text(
                  "DONE",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class FailureModal extends StatelessWidget {
  const FailureModal({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: PAGE_HEIGHT * 0.6,
      width: PAGE_WIDTH * 0.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40.0,
                  child: Icon(
                    Icons.close,
                    color: Colors.red,
                    size: 50.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 30.0, bottom: 10.0),
                  child: Text("OH NO",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 20.0)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 10.0),
                  child: Text(
                    "Failure is the mother of success. Don't give up!",
                    style:
                    TextStyle(fontWeight: FontWeight.w300),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: SizedBox.expand(
              child: FlatButton(
                color: Colors.red[700],
                child: Text(
                  "TRY AGAIN",
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w300),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
