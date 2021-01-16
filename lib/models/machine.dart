import 'package:cloud_firestore/cloud_firestore.dart';

class Machine {
  String machineId;
  String machineName;
  String machineLocation;
  String image;
  String userId;
  Timestamp createdAt;
  Timestamp updatedAt;

  Machine();

  Machine.fromMap(Map<String, dynamic> data) {
    machineId = data['machineId'];
    machineName = data['machineName'];
    machineLocation = data['machineLocation'];
    userId = data['userId'];
    image = data['image'];
    createdAt = data['createdAt'];
    updatedAt = data['updatedAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'machineId': machineId,
      'machineName': machineName,
      'machineLocation': machineLocation,
      'userId': userId,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}