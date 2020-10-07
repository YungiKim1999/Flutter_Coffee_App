import 'package:flutter/material.dart';
import 'package:ninjabrewcrew/services/auth.dart';
import 'package:ninjabrewcrew/shared/constants.dart';
import 'package:ninjabrewcrew/shared/loading.dart';

class SignIn extends StatefulWidget {
  final Function toggleViewFunc;

  SignIn({this.toggleViewFunc});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  //textfield states
  String email = '';
  String password = '';
  String errorMsg = '';

  //loading state
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign In to Brew Crew'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleViewFunc();
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: TextInputDecorationforEmail,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'enter an email';
                    } else {
                      return null;
                    }
                  },
                  onChanged: (val) {
                    setState(() {
                      email = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration: TextInputDecorationforPassword,
                  validator: (val) {
                    if (val.isEmpty) {
                      return 'enter a password';
                    } else if (val.length < 6) {
                      return 'Enter a password with 6+ characters';
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  onChanged: (val) {
                    setState(() {
                      password = val;
                    });
                  },
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Colors.brown[400],
                  child: Text(
                    'Sign In',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(
                          email, password);
                      if (result == null) {
                        setState(() {
                          errorMsg = 'invalid email/password';
                          loading = false;
                        });
                      }
                    }
                  },
                ),
                SizedBox(
                  height: 12.0,
                ),
                Text(
                  errorMsg,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          )),
    );
  }
}
