import 'package:daily_ui/calculator.dart';
import 'package:flutter/material.dart';

const PAGE_HEIGHT = 600.0;
const PAGE_WIDTH = 300.0;

class CalculatorWidget extends StatefulWidget {
  @override
  _CalculatorWidgetState createState() => _CalculatorWidgetState();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.white,
        accentColor: Colors.purpleAccent[700],
        textTheme: TextTheme(
            headline1: TextStyle(
                fontSize: 52.0,
                fontWeight: FontWeight.w500,
                color: Colors.white.withOpacity(1.0)),
            bodyText1: TextStyle(fontSize: 18),
            bodyText2: TextStyle(fontSize: 18.0, color: Colors.purpleAccent)),
      ),
      home: Scaffold(body: Center(child: CalculatorWidget())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  CalcController _calcController = CalcController();

  String _result = '';
  String _working = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: PAGE_WIDTH,
      height: PAGE_HEIGHT,
      color: Colors.black,
      child: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.bottomRight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      _working,
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      _result,
                      style: Theme.of(context).textTheme.headline1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                )),
          ),
          Expanded(
            flex: 2,
            child: GridView.count(
                crossAxisCount: 4,
                mainAxisSpacing: 5.0,
                children: [
                  _clearButton(),
                  _calculatorButton('/', operator: true),
                  _calculatorButton('×', operator: true),
                  _deleteButton(),
                  _calculatorButton('7'),
                  _calculatorButton('8'),
                  _calculatorButton('9'),
                  _calculatorButton('+', operator: true),
                  _calculatorButton('4'),
                  _calculatorButton('5'),
                  _calculatorButton('6'),
                  _calculatorButton('-', operator: true),
                  _calculatorButton('1'),
                  _calculatorButton('2'),
                  _calculatorButton('3'),
                  _equalButton(),
                  Text(''),
                  _calculatorButton('0'),
                  _calculatorButton('.'),
                  Text('')
                ]),
          )
        ],
      ),
    );
  }

  Widget _calculatorButton(String inputStr, {bool operator = false}) {
    return FlatButton(
      child: Text(inputStr,
          style: operator
              ? Theme.of(context).textTheme.bodyText2
              : Theme.of(context).textTheme.bodyText1),
      highlightColor: Colors.purpleAccent,
      hoverColor: Colors.purpleAccent[700].withOpacity(0.4),
      onPressed: () {
        _calcController.parse(inputStr);
        setState(() {
          _working = _calcController.getWorkingStatement();
          _result = '';
        });
      },
    );
  }

  Widget _clearButton() {
    return FlatButton(
      child: Text('C', style: Theme.of(context).textTheme.bodyText2),
      highlightColor: Colors.purpleAccent,
      hoverColor: Colors.purpleAccent[700].withOpacity(0.4),
      onPressed: () {
        _calcController.clear();
        setState(() {
          _working = '';
          _result = '';
        });
      },
    );
  }

  Widget _deleteButton() {
    return IconButton(
      icon: Icon(Icons.backspace),
      color: Theme.of(context).accentColor,
      highlightColor: Colors.purpleAccent,
      hoverColor: Colors.purpleAccent[700].withOpacity(0.4),
      onPressed: () {
        _calcController.delete();
        setState(() {
          _result = '';
          _working = _calcController.getWorkingStatement();
        });
      },
    );
  }

  Widget _equalButton() {
    return FlatButton(
      child: Text('=', style: Theme.of(context).textTheme.bodyText2),
      highlightColor: Colors.purpleAccent,
      hoverColor: Colors.purpleAccent[700].withOpacity(0.4),
      onPressed: () {
        String result = _calcController.execute();
        setState(() {
          if (result != null) {
            _result = result;
          } else {
            _working = _calcController.getWorkingStatement();
          }
        });
      },
    );
  }
}
