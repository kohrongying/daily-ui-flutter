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

class ArticleWidget extends StatelessWidget {
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
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                            opacity: a1.value,
                            child: Dialog(
                              backgroundColor: Colors.green[300],
                              child: SuccessModal(),
                            )
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {}
                      );
                },
              ),
              RaisedButton(
                color: Colors.red,
                child: Text("NAY"),
                onPressed: () {
                  showGeneralDialog(
                      barrierColor: Colors.black.withOpacity(0.5),
                      transitionBuilder: (context, a1, a2, widget) {
                        return Transform.scale(
                          scale: a1.value,
                          child: Opacity(
                              opacity: a1.value,
                              child: Dialog(
                                backgroundColor: Colors.red,
                                child: FailureModal(),
                              )
                          ),
                        );
                      },
                      transitionDuration: Duration(milliseconds: 200),
                      barrierDismissible: true,
                      barrierLabel: '',
                      context: context,
                      pageBuilder: (context, animation1, animation2) {}
                  );
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
