import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:daily_ui/dui-014-countdown.dart';

void main(){
  test('next friday date', () {
    DateTime today = DateTime(2020, 7, 29);
    DateTime endOfWork = getFridayDate(today);
    expect(endOfWork, DateTime(2020, 7, 31, 18,0));
  });

  test('next friday date 2', () {
    DateTime today = DateTime(2020, 7, 31, 19);
    DateTime endOfWork = getFridayDate(today);
    expect(endOfWork, DateTime(2020, 7, 31, 18,0));
    expect(endOfWork.isBefore(today), true);
  });

}