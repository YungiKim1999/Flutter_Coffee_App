import 'package:flutter/material.dart';
import 'package:ninjabrewcrew/models/user.dart';
import 'package:ninjabrewcrew/screens/authenticate/authenticate.dart';
import 'package:ninjabrewcrew/screens/home/home.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if(user == null){
        return Authenticate();
    }else{
      return Home();
    }
  }
}
