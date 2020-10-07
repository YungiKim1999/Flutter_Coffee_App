import 'package:flutter/material.dart';
import 'package:ninjabrewcrew/screens/authenticate/register.dart';
import 'package:ninjabrewcrew/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  //state holding whether to show sign in page or not
  bool signIn = true;
  void toggleView(){
    setState(() {
      signIn = !signIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(signIn){
      return SignIn(toggleViewFunc: toggleView);
    }else{
      return Register(toggleViewFunc: toggleView);
    }
  }
}
