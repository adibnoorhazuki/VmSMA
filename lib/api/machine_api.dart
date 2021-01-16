import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as path;
import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vendingapps/models/machine.dart';
import 'package:vendingapps/notifier/machine_notifier.dart';

getMachine(MachineNotifier machineNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('machine')
      .orderBy("createdAt", descending: true)
      .getDocuments();

  List<Machine> _machineList = [];

  snapshot.documents.forEach((document) {
    Machine machine = Machine.fromMap(document.data);
    String userId = machine.userId;

    Future<String> inputData() async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String currUID = user.uid.toString();

      if(userId == currUID){
        _machineList.add(machine);
      }

      return currUID;
    }

    inputData();
  });

  machineNotifier.machineList = _machineList;
}

uploadMachineAndImage(Machine machine, bool isUpdating, File localFile, Function machineUploaded) async {
  if(localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('$uuid$fileExtension');

    await firebaseStorageRef.putFile(localFile).onComplete.catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download Url: $url");
    _uploadMachine(machine, isUpdating, machineUploaded, imageUrl: url);

  } else {
    print('...Skipping image upload');
    _uploadMachine(machine, isUpdating, machineUploaded);
  }
}

_uploadMachine(Machine machine, bool isUpdating, Function machineUploaded, {String imageUrl}) async {

  CollectionReference machineRef = Firestore.instance.collection('machine');

  if(imageUrl != null) {
    machine.image = imageUrl;
  }

  if(isUpdating) {
    machine.updatedAt = Timestamp.now();

    await machineRef.document(machine.machineId).updateData(machine.toMap());

    machineUploaded(machine);
    print('updated machine with id: ${machine.machineId}');

  } else {
    machine.createdAt = Timestamp.now();

    DocumentReference documentRef = await machineRef.add(machine.toMap());

    machine.machineId = documentRef.documentID;

    print('uploaded machine successfully: ${machine.toString()}');

    await documentRef.setData(machine.toMap(), merge:true);

    machineUploaded(machine);
  }

}

deleteMachine(Machine machine, Function machineDeleted) async {
  if(machine.image != null) {
    StorageReference storageReference = 
        await FirebaseStorage.instance.getReferenceFromUrl(machine.image);

        print(storageReference.path);

        await storageReference.delete();

        print('Image Deleted!');
  }

  await Firestore.instance.collection('machine').document(machine.machineId).delete();
  machineDeleted(machine);

}