import 'dart:math';

class CalcController {
  String firstInput = '';
  OperatorSymbol command;
  String secondInput = '';

  void clear() {
    firstInput = '';
    secondInput = '';
    command = null;
  }

  String execute() {
    if (firstInput.isNotEmpty && secondInput.isNotEmpty && command != null) {
      String resultString = Calculator(
              double.parse(firstInput), double.parse(secondInput), command)
          .calculate();
      firstInput = resultString;
      secondInput = "";
      return resultString;
    }
    return null;
  }

  String getWorkingStatement() {
    String firstInputStr = firstInput.isEmpty ? '' : firstInput;
    String commandStr =
        command == null ? '' : ' ${OperatorSymbolHelper.getValue(command)}';
    String secondInputStr = secondInput.isEmpty ? '' : ' $secondInput';
    return firstInputStr + commandStr + secondInputStr;
  }

  void parse(String inputString) {
    switch (inputString) {
      case "+":
        command = OperatorSymbol.add;
        break;
      case "-":
        {
          if (command == null && firstInput.isEmpty) {
            firstInput += inputString;
          } else if (command == OperatorSymbol.multiply ||
              command == OperatorSymbol.divide) {
            secondInput += inputString;
          } else {
            command = OperatorSymbol.subtract;
          }
          break;
        }
      case "×":
        command = OperatorSymbol.multiply;
        break;
      case "/":
        command = OperatorSymbol.divide;
        break;
      case ".":
        {
          if (command == null) {
            if (!firstInput.contains('.')) {
              firstInput += inputString;
            }
          } else {
            if (!secondInput.contains(('.'))) {
              secondInput += inputString;
            }
          }
          break;
        }
      default:
        {
          if (command == null) {
            firstInput += inputString;
          } else {
            secondInput += inputString;
          }
        }
    }
  }

  void delete() {
    if (secondInput.isNotEmpty) {
      secondInput = secondInput.substring(0, secondInput.length - 1);
    } else if (command != null) {
      command = null;
    } else if (firstInput.isNotEmpty) {
      firstInput = firstInput.substring(0, firstInput.length - 1);
    }
  }
}

class Calculator {
  double firstInput;
  double secondInput;
  OperatorSymbol currCommand;
  Calculator(this.firstInput, this.secondInput, this.currCommand);

  String calculate() {
    switch (currCommand) {
      case OperatorSymbol.add:
        {
          return (firstInput + secondInput).formatDouble();
        }
      case OperatorSymbol.subtract:
        {
          return (firstInput - secondInput).formatDouble();
        }
      case OperatorSymbol.multiply:
        {
          return (firstInput * secondInput).formatDouble();
        }
      case OperatorSymbol.divide:
        {
          if (secondInput == 0) {
            return "Error";
          }
          return (firstInput / secondInput).toPrecision(5).formatDouble();
        }
      default:
        return null;
    }
  }
}

enum OperatorSymbol { add, subtract, multiply, divide }

class OperatorSymbolHelper {
  static String getValue(OperatorSymbol sym) {
    switch (sym) {
      case OperatorSymbol.add:
        return "+";
      case OperatorSymbol.subtract:
        return "-";
      case OperatorSymbol.multiply:
        return "×";
        break;
      case OperatorSymbol.divide:
        return "/";
        break;
      default:
        return "";
    }
  }
}

extension FormatDoubleToString on double {
  String formatDouble() {
    int intValue = this.toInt();
    if (this - intValue == 0) {
      return intValue.toString();
    } else {
      return this.toString();
    }
  }
}

extension Precision on double {
  double toPrecision(int fractionDigits) {
    double mod = pow(10, fractionDigits.toDouble());
    return ((this * mod).round().toDouble() / mod);
  }
}
