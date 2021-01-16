
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendingapps/models/drink.dart';
import 'package:vendingapps/notifier/drink_notifier.dart';

getDrink(DrinkNotifier drinkNotifier, mId) async {

  QuerySnapshot snapshot = await Firestore.instance
      .collection('drink')
      .getDocuments();

  List<Drink> _drinkList = [];

  snapshot.documents.forEach((document) {
    Drink drink = Drink.fromMap(document.data);
    
    // Future<String> inputData() async {
    //   final firestoreInstance = Firestore.instance;
    //   firestoreInstance.collection("drink").getDocuments().then((querySnapshot) {
    //     querySnapshot.documents.forEach((result) {
    //       if(result.data.machineId == mId){
    //         _drinkList.add(drink);
    //       }
    //     });
    //   });
    //   return mId;
    // }
    // inputData();

    if(drink.machineId == mId){
      _drinkList.add(drink);
    }
  });

  drinkNotifier.drinkList = _drinkList;
 
}

uploadDrink(Drink drink, bool isUpdating, Function drinkUploaded) async {
  CollectionReference drinkRef = Firestore.instance.collection('drink');

  if(isUpdating) {

    await drinkRef.document(drink.drinkId).updateData(drink.toMap());

    drinkUploaded(drink);

    print('updated drink with Id: ${drink.drinkId}');

  } else {

    DocumentReference documentRef = await drinkRef.add(drink.toMap());

    drink.drinkId = documentRef.documentID;

    print('upload drink success: ${drink.toString()}');

    await documentRef.setData(drink.toMap(), merge:true);

    drinkUploaded(drink);
  }
}

deleteDrink(Drink drink, Function drinkDeleted) async {
  
  await Firestore.instance.collection('drink').document(drink.drinkId).delete();

  drinkDeleted(drink);
}

totalDrink(Drink drink, Function drinkTotal) async {

  final FirebaseUser user = await FirebaseAuth.instance.currentUser();
  final String currUID = user.uid.toString();
  
    QuerySnapshot _myDoc = await Firestore.instance.collection('drink').where('userId', isEqualTo: currUID).getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    print(_myDocCount.length);  // Count of Documents in Collection

}