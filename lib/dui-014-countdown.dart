import 'package:flutter/material.dart';
import 'dart:async';

const PAGE_HEIGHT = 300.0;
const PAGE_WIDTH = 600.0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Scaffold(body: Center(child: CountdownWidget())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CountdownWidget extends StatefulWidget {
  @override
  _CountdownWidgetState createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  int _numDays = 0;
  int _numHours = 0;
  int _numMinutes = 0;
  int _numSeconds = 0;
  bool _isWeekend = false;
  Timer _timer;
  @override
  void initState() {
    DateTime today = DateTime.now();
    if (today.weekday > 5) {
      setState(() => _isWeekend = true);
    } else {
      DateTime endOfWork = getFridayDate(today);
      if (endOfWork.isBefore(DateTime.now())) {
        setState(() => _isWeekend = true);
      } else {
        _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
          Duration difference = endOfWork.difference(DateTime.now());
          setState(() {
            int daysDiff = difference.inDays;
            int hoursDiff = difference.inHours;
            int minsDiff = difference.inMinutes;
            _numDays = daysDiff;
            _numHours = hoursDiff - daysDiff * Duration.hoursPerDay;
            _numMinutes = minsDiff - hoursDiff * Duration.minutesPerHour;
            _numSeconds =
                difference.inSeconds - minsDiff * Duration.secondsPerMinute;
          });
        });
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: PAGE_WIDTH,
        height: PAGE_HEIGHT,
        padding: EdgeInsets.symmetric(horizontal: 60.0, vertical: 30.0),
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DurationColumn(value: _numDays, label: "days"),
                  SizedBox(
                    width: 10.0,
                  ),
                  DurationColumn(value: _numHours, label: "hours"),
                  SizedBox(
                    width: 10.0,
                  ),
                  DurationColumn(value: _numMinutes, label: "minutes"),
                  SizedBox(
                    width: 10.0,
                  ),
                  DurationColumn(value: _numSeconds, label: "seconds")
                ],
              ),
            ),
            Center(
                child: Text(
              _isWeekend ? "It's the weekend!" : "to the weekend",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300),
            ))
          ],
        ));
  }
}

class DurationColumn extends StatelessWidget {
  const DurationColumn({
    Key key,
    @required int value,
    @required String label,
  })  : _value = value,
        _label = label,
        super(key: key);

  final int _value;
  final String _label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_value.toString(),
                    style: TextStyle(
                        fontSize: 80.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange)),
          Text(
            _label.toUpperCase(),
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w300),
          )
        ],
      ),
    );
  }
}

DateTime getFridayDate(today) {
  int daysTillFriday = (DateTime.friday - today.weekday) % 7;
  DateTime friday = today.add(Duration(days: daysTillFriday));
  DateTime endOfWork = DateTime(friday.year, friday.month, friday.day, 18, 0);
  return endOfWork;
}
