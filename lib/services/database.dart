import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ninjabrewcrew/models/brew.dart';
import 'package:ninjabrewcrew/models/user.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection = Firestore.instance.collection('brews');

  Future updateUserdata(String sugars, String name, int strength) async{
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  //brewlist from snapshot

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }


  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'] ,
      sugars: snapshot.data['sugars'] ,
      strength: snapshot.data['strength'],
    );
  }

  //get brews stream
  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}