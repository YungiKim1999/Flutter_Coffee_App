import 'package:flutter/material.dart';
import 'package:ninjabrewcrew/models/brew.dart';
import 'package:ninjabrewcrew/screens/home/brew_list.dart';
import 'package:ninjabrewcrew/screens/home/settings_form.dart';
import 'package:ninjabrewcrew/services/auth.dart';
import 'package:ninjabrewcrew/services/database.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    void _showSettingPanel() {
      showModalBottomSheet(
          context: context,
          builder: (container) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: SettingsForm(),
            );
          });
    }

    return StreamProvider<List<Brew>>.value(
      value: DatabaseService().brews,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
                onPressed: () async {
                  _auth.signOut();
                },
                icon: Icon(Icons.person),
                label: Text('Sign Out')),
            FlatButton.icon(
                onPressed: () {
                  _showSettingPanel();
                },
                icon: Icon(Icons.settings),
                label: Text(
                  'Setting',
                )),
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: BrewList()),
      ),
    );
  }
}
