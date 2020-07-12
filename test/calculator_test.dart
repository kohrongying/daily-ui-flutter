import 'package:flutter_test/flutter_test.dart';
import 'package:daily_ui/calculator.dart';

void main(){

  group('Calculator', () {

    test('Set Inputs', () {
      final calc = Calculator(5.0, 10.0, OperatorSymbol.add);
      expect(calc.firstInput, 5.0);
      expect(calc.secondInput, 10.0);
      expect(calc.currCommand, OperatorSymbol.add);
    });

    test("Get Integer Result", () {
      final calc = Calculator(10.0, 5.0, OperatorSymbol.add);
      expect(calc.calculate(), "15");

      final calc2 = Calculator(10.0, 5.0, OperatorSymbol.subtract);
      expect(calc2.calculate(), "5");

      final calc3 = Calculator(10.0, 5.0, OperatorSymbol.multiply);
      expect(calc3.calculate(), "50");

      final calc4 = Calculator(10.0, 5.0, OperatorSymbol.divide);
      expect(calc4.calculate(), "2");
    });

    test("Get Double Result", () {
      final calc = Calculator(10.0, 5.5, OperatorSymbol.add);
      expect(calc.calculate(), "15.5");

      final calc2 = Calculator(5.5, 10, OperatorSymbol.subtract);
      expect(calc2.calculate(), "-4.5");

      final calc3 = Calculator(5.5, 10, OperatorSymbol.multiply);
      expect(calc3.calculate(), "55");

      final calc4 = Calculator(5.5, 10, OperatorSymbol.divide);
      expect(calc4.calculate(), "0.55");
    });

    test("Get Result", () {
      final calc = Calculator(5.0, 0, OperatorSymbol.divide);
      expect(calc.calculate(), 'Error');
    });
  });

  group('Calculator Controller', () {

    test('Parse first input', () {
      final controller = CalcController();
      controller.parse("1");
      expect(controller.firstInput, "1");
    });

    test('Parse first command', () {
      final controller = CalcController();
      controller.parse("1");
      controller.parse("+");
      expect(controller.firstInput, "1");
      expect(controller.command, OperatorSymbol.add);
    });

    test('Parse second input', () {
      final controller = CalcController();
      controller.parse("1");
      controller.parse("+");
      controller.parse("1");

      expect(controller.firstInput, "1");
      expect(controller.command, OperatorSymbol.add);
      expect(controller.secondInput, "1");
    });

    test('Execute', () {
      final controller = CalcController();
      controller.parse("1");
      controller.parse("+");
      controller.parse("1");
      final result = controller.execute();
      expect(result, "2");
    });

    test('Parse number for more than 1 digit for first input', () {
      final controller = CalcController();
      controller.parse("1");
      controller.parse("0");
      expect(controller.firstInput, "10");
      controller.parse("0");
      expect(controller.firstInput, "100");
    });

    test('Parse number for more than 1 digit for second input', () {
      final controller = CalcController();
      controller.parse("1");
      controller.parse("+");
      controller.parse("1");
      controller.parse("1");
      controller.parse("0");
      expect(controller.secondInput, "110");
    });

    test('Execute consecutively', () {
      final controller = CalcController();
      controller.parse("1");
      controller.parse("+");
      controller.parse("1");
      controller.execute();
      controller.parse("+");
      controller.parse("1");
      final result = controller.execute();
      expect(result, "3");
    });

    group('Decimal input', () {
      test('Happy path', () {
        final controller = CalcController();
        controller.parse("1");
        controller.parse(".");
        controller.parse("5");
        controller.parse("*");
        controller.parse("2");
        final result = controller.execute();
        expect(result, "3");
      });

      test('No digit after decimal', () {
        final controller = CalcController();
        controller.parse("1");
        controller.parse(".");
        controller.parse("*");
        controller.parse("2");
        final result = controller.execute();
        expect(result, "2");
      });

      test('No digit before decimal', (){
        final controller = CalcController();
        controller.parse(".");
        controller.parse("5");
        controller.parse("-");
        controller.parse("2");
        final result = controller.execute();
        expect(result, "-1.5");
      });
    });

    test('Clear', () {
      final controller = CalcController();
      controller.parse("1");
      controller.parse(".");
      controller.parse("*");
      controller.parse("2");
      controller.execute();
      controller.clear();
      expect(controller.firstInput, '');
      expect(controller.secondInput, '');
      expect(controller.command, null);
    });

    group('Handle negative numbers', (){
      test('First input is negative', () {
        final controller = CalcController();
        controller.parse("-");
        controller.parse("5");
        controller.parse("+");
        controller.parse("3");
        final result = controller.execute();
        expect(result, "-2");
      });

      test('Multiply by negative number', () {
        final controller = CalcController();
        controller.parse("5");
        controller.parse("*");
        controller.parse("-");
        controller.parse("3");
        final result = controller.execute();
        expect(result, "-15");
      });

      test('Divide by negative number', () {
        final controller = CalcController();
        controller.parse("-");
        controller.parse("6");
        controller.parse("/");
        controller.parse("3");
        final result = controller.execute();
        expect(result, "-2");
      });

      test('Add negative number', () {
        final controller = CalcController();
        controller.parse("6");
        controller.parse("+");
        controller.parse("-");
        controller.parse("3");
        final result = controller.execute();
        expect(result, "3");
      });
    });

    group('Get working statement', () {
      test('After first input', (){
        final controller = CalcController();
        controller.parse("6");
        final result = controller.getWorkingStatement();
        expect(result, "6");
      });

      test('After first command', (){
        final controller = CalcController();
        controller.parse("6");
        controller.parse("+");
        final result = controller.getWorkingStatement();
        expect(result, "6 +");
      });

      test('After second input', (){
        final controller = CalcController();
        controller.parse("6");
        controller.parse("+");
        controller.parse("-");
        controller.parse("3");
        final result = controller.getWorkingStatement();
        expect(result, "6 - 3");
      });

      test('Consecutive execute', () {
        final controller = CalcController();
        controller.parse("6");
        controller.parse("+");
        controller.parse("-");
        controller.parse("3");

        final result = controller.execute();
        expect(result, "3");
      });
    });

    group('Handle delete', () {
      test('Delete first input', (){
        final controller = CalcController();
        controller.parse("6");
        controller.delete();
        final result = controller.getWorkingStatement();
        expect(result, "");
      });

      test('Delete command', (){
        final controller = CalcController();
        controller.parse("6");
        controller.parse("+");
        controller.delete();
        final result = controller.getWorkingStatement();
        expect(result, "6");
      });

      test('Delete second input', (){
        final controller = CalcController();
        controller.parse("6");
        controller.parse("+");
        controller.parse("6");
        controller.delete();
        final result = controller.getWorkingStatement();
        expect(result, "6 +");
      });

      test('Delete 4 times', (){
        final controller = CalcController();
        controller.parse("6");
        controller.parse("+");
        controller.parse("6");
        controller.delete();
        controller.delete();
        controller.delete();
        controller.delete();
        final result = controller.getWorkingStatement();
        expect(result, "");
      });

      test('Delete when no input', (){
        final controller = CalcController();
        controller.delete();
        final result = controller.getWorkingStatement();
        expect(result, "");
      });
    });

    group('Handle edge cases', () {
      test('Execute without command', (){ // 6 =
        final controller = CalcController();
        controller.parse("6");
        controller.execute();
        expect(controller.getWorkingStatement(), "6");
      });

      test('Execute without second input', (){ // 6 + =
        final controller = CalcController();
        controller.parse("6");
        controller.parse("+");
        controller.execute();
        expect(controller.getWorkingStatement(), "6 +");
      });

      test('Allow only one decimal point', (){
        //3.20.2 or 3..2 is not allowed
        final controller = CalcController();
        controller.parse("6");
        controller.parse(".");
        controller.parse(".");
        controller.parse("5");
        controller.parse(".");
        expect(controller.getWorkingStatement(), "6.5");
      });
    });
  });
}

