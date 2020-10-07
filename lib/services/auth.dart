import 'package:firebase_auth/firebase_auth.dart';
import 'package:ninjabrewcrew/models/user.dart';
import 'package:ninjabrewcrew/screens/authenticate/authenticate.dart';
import 'package:ninjabrewcrew/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create custom user based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
      return user != null ? User(uid: user.uid) : null;
  }

  //stream for listening for change user
  Stream<User> get user{
     return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in with email and password
  Future signInWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email and password

  Future registerWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      //register the user to the database
      await DatabaseService(uid: user.uid).updateUserdata('0', 'new crew member', 100);

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }

}
