import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection references
  final CollectionReference vmCollection = Firestore.instance.collection('vending');
  // final CollectionReference userCollection = Firestore.instance.collection('User');

    // Future updateUserData(String fullname, String email, String password)

    Future updateUserData(String name, String email, String pass) async {
      return await vmCollection.document(uid).setData({
        'name': name,
        'email': email,
        'pass': pass,
    });
  }
}