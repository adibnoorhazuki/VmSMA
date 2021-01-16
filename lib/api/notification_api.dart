import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendingapps/models/notifications.dart';
import 'package:vendingapps/notifier/notifications_notifier.dart';

getNotification(NotificationNotifier notificationNotifier) async {
  QuerySnapshot snapshot = await Firestore.instance
      .collection('notifications')
      .orderBy("createdAt", descending: true)
      .getDocuments();

  List<Notifications> _notificationList = [];

  snapshot.documents.forEach((document) {
    Notifications notifications = Notifications.fromMap(document.data);
    String userId = notifications.userId;

    Future<String> inputData() async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String currUID = user.uid.toString();

      if(userId == currUID){
        _notificationList.add(notifications);
      }

      return currUID;
    }

    inputData();
  });

  notificationNotifier.notificationList = _notificationList;
}