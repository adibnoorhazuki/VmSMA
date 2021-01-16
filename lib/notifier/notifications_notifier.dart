import 'dart:collection';

import 'package:vendingapps/models/notifications.dart';
import 'package:flutter/cupertino.dart';

class NotificationNotifier with ChangeNotifier {
  List<Notifications> _notificationList = [];
  Notifications _currentNotification;

  UnmodifiableListView<Notifications> get notificationList => UnmodifiableListView(_notificationList);

  Notifications get currentNotification => _currentNotification;

  set notificationList(List<Notifications> notificationList) {
    _notificationList = notificationList;
    notifyListeners();
  }

  set currentNotification(Notifications notifications) {
    _currentNotification = notifications;
    notifyListeners();
  }
}