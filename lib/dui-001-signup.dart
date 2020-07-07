import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.grey,
          body: Center(child: SignUpPageWidget())),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignUpPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 800.0,
        height: 400.0,
        color: Colors.white,
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(
            flex: 1,
            child: HeroWidget(),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SignUpWidget(),
            ),
          )
        ]));
  }
}

class HeroWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 300,
          height: 500,
          color: Colors.green.withOpacity(0.2),
        ),
        Container(
          width: 150,
          height: 500,
          color: Colors.green.withOpacity(0.5),
        ),
        Container(
          width: 50,
          height: 500,
          color: Colors.green.withOpacity(0.6),
        ),
        Container(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.only(top: 56.0, right: 24.0),
              child: Text(
                "Join Our\n Community",
                style: TextStyle(fontSize: 60.0, fontWeight: FontWeight.w800),
                textAlign: TextAlign.right,
              ),
            ))
      ],
    );
  }
}

class SignUpWidget extends StatefulWidget {
  @override
  _SignUpWidgetState createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _confirmPasswordTextController = TextEditingController();
  bool _checked = false;

  final _formKey = GlobalKey<FormState>();

  bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return (!regex.hasMatch(value)) ? false : true;
  }

  bool validatePassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: TextFormField(
                autofocus: true,
                controller: _emailTextController,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  labelText: 'Email',
                ),
                validator: (value) {
                  if (!validateEmail(value)) {
                    return 'Please enter valid email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: TextFormField(
                controller: _passwordTextController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (!validatePassword(value)) {
                    return "Password must contain at least one uppercase character, lowercase character, one number and one special character and be at least 8 characters long";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
              child: TextFormField(
                controller: _confirmPasswordTextController,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    labelText: "Confirm Password"),
                obscureText: true,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Password must not be empty";
                  }
                  if (value != _passwordTextController.text) {
                    return "Password must match";
                  }
                  return null;
                },
              ),
            ),
            CheckboxListTile(
              title: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "By signing up I agree to the ",
                      style: TextStyle(color: Colors.grey)),
                  TextSpan(
                      text: "Terms and Conditions",
                      style: TextStyle(color: Colors.greenAccent[700])),
                ], style: TextStyle(fontSize: 12.0)),
              ),
              controlAffinity: ListTileControlAffinity.leading,
              value: _checked,
              onChanged: (bool value) {
                setState(() {
                  _checked = value;
                });
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 25.0),
                child: Row(
                  children: [
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 36.0),
                      color: Colors.greenAccent[700],
                      disabledColor: Colors.grey[400],
                      child: Text("Sign up",
                          style: TextStyle(color: Colors.white)),
                      onPressed: _checked
                          ? () {
                        if (_formKey.currentState.validate()) {
                          Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Sign up success!')));
                        }
                      }
                          : null,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "or ", style: TextStyle(color: Colors.grey)),
                            TextSpan(
                                text: "Log in",
                                style: TextStyle(color: Colors.greenAccent[700]))
                          ])),
                    )
                  ],
                ),
              ),
            )
          ],
        ));
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _confirmPasswordTextController.dispose();
  }
}
