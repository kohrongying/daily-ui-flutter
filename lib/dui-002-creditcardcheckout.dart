import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(child: CheckoutPageWidget())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CheckoutPageWidget extends StatefulWidget {
  @override
  _CheckoutPageWidgetState createState() => _CheckoutPageWidgetState();
}

class _CheckoutPageWidgetState extends State<CheckoutPageWidget> {
  final _currentStep = 2;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600.0,
      height: 500.0,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: PaymentWidget(),
          )
        ],
      ),
    );
  }
}

class PaymentWidget extends StatefulWidget {
  @override
  _PaymentWidgetState createState() => _PaymentWidgetState();
}

class _PaymentWidgetState extends State<PaymentWidget> {
  final _nameTextController = TextEditingController();
  final _cardNumberTextController = TextEditingController();
  final _cvcTextController = TextEditingController();
  final _expiryDateTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text("Payment Detail", style: TextStyle(fontSize: 40.0)),
          ),
          Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 16.0),
                  child: Text("Name on Card"),
                ),
                TextFormField(
                  autofocus: true,
                  controller: _nameTextController,
                  decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      hintText: "JOHN SMITH"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 16.0),
                  child: Text("Card Number"),
                ),
                TextFormField(
                  autofocus: true,
                  controller: _cardNumberTextController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    WhitelistingTextInputFormatter.digitsOnly,
                    new LengthLimitingTextInputFormatter(19),
                    CardNumberInputFormatter(),
                  ],
                  decoration: InputDecoration(
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: InputBorder.none,
                      hintText: "5642 4418 1234 5678"),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 16.0),
                  child: Row(
                    children: [
                      Expanded(flex: 1, child: Text("Expiration")),
                      Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text("CVC"),
                              ),
                              Tooltip(
                                message: "3 digit security number",
                                preferBelow: false,
                                verticalOffset: 8.0,
                                child: Icon(
                                  Icons.help_outline,
                                  color: Colors.grey[400],
                                  size: 18.0,
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        autofocus: true,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          new LengthLimitingTextInputFormatter(6),
                          ExpiryDateInputFormatter()
                        ],
                        controller: _expiryDateTextController,
                        decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            border: InputBorder.none,
                            hintText: "MM / YYYY"),
                      ),
                    ),
                    Spacer(),
                    Expanded(
                      flex: 2,
                      child: TextFormField(
                        autofocus: true,
                        controller: _cvcTextController,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          new LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: InputDecoration(
                            fillColor: Colors.grey[200],
                            filled: true,
                            border: InputBorder.none,
                            hintText: "987"),
                      ),
                    )
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 36.0, bottom: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("← Back to Checkout Page", style: TextStyle(color: Colors.grey[400]),),
                        RaisedButton(
                          padding: const EdgeInsets.all(0.0),
                          onPressed: () {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text('Sign up success!')));
                          },
//                          shape: RoundedRectangleBorder(
//                              borderRadius: BorderRadius.circular(80.0)),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blueAccent[700],
                                  Colors.deepPurple
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 36.0, vertical: 18.0),
                              child: Text(
                                "Confirm Order",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameTextController.dispose();
    _cardNumberTextController.dispose();
    _cvcTextController.dispose();
    super.dispose();
  }
}

class CardNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var buffer = new StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      var nonZeroIndex = i + 1;
      if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
        buffer.write('  '); // Add double spaces.
      }
    }

    var string = buffer.toString();
    return newValue.copyWith(
        text: string,
        selection: new TextSelection.collapsed(offset: string.length));
  }
}

class ExpiryDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = newValue.text;

    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    var updatedString = text;
    if (text.length >= 2) {
      updatedString = text.substring(0, 2) + " / " + text.substring(2);
    }

    return newValue.copyWith(
        text: updatedString,
        selection: new TextSelection.collapsed(offset: updatedString.length));
  }
}
