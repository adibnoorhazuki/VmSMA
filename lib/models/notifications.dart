import 'package:cloud_firestore/cloud_firestore.dart';

class Notifications {

   String notiId;
   String notiTitle;
   String notiBody;
   String userId;
   String machineId;
   Timestamp createdAt;

  Notifications();

  Notifications.fromMap(Map<String, dynamic> data) {
    notiId = data['notiId'];
    notiTitle = data['notiTitle'];
    notiBody = data['notiBody'];
    userId = data['userId'];
    machineId = data['machineId'];
    createdAt = data['createdAt'];
  }

  Map<String, dynamic> toMap() {
    return {
      'notiId': notiId,
      'notiTitle': notiTitle,
      'notiBody': notiBody,
      'userId': userId,
      'machineId': machineId,
      'createdAt': createdAt,
    };
  }
}