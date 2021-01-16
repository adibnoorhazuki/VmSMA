import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/api/notification_api.dart';
import 'package:vendingapps/notifier/notifications_notifier.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/screen/notifications/notifications_details.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';

class Notifications extends StatefulWidget {

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  @override
  void initState() {
    NotificationNotifier notificationNotifier = Provider.of<NotificationNotifier>(context, listen: false);
    getNotification(notificationNotifier);
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ), 
        backgroundColor: Colors.yellowAccent[700],
        elevation: 0.0,
      ),
      bottomNavigationBar: CustomAppBar(),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          NotificationsTopPart(),
          NotificationsBodyPart(),
        ],
      )
    );
  }

}

class NotificationsTopPart extends StatefulWidget {
  @override
  _NotificationsTopPartState createState() => _NotificationsTopPartState();
}

class _NotificationsTopPartState extends State<NotificationsTopPart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
          height: 200.0, 
          width: 500.0,
          color: Colors.yellowAccent[700],
          child: Column(
            children: <Widget> [
              SizedBox(height: 30.0),
              Text('Notifications List', 
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 34.0, 
                color: Colors.black,
              ), 
              textAlign: TextAlign.center,
              )
            ],
          ),
          ),
        ),
      ],
    );
  }
}

class NotificationsBodyPart extends StatefulWidget {
  @override
  _NotificationsBodyPartState createState() => _NotificationsBodyPartState();
}

class _NotificationsBodyPartState extends State<NotificationsBodyPart> {

  @override
  void initState() {
    NotificationNotifier notificationNotifier = Provider.of<NotificationNotifier>(context, listen: false);
    getNotification(notificationNotifier);
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    NotificationNotifier notificationNotifier = Provider.of<NotificationNotifier>(context);

    return Expanded(
      child: notificationNotifier.notificationList.isEmpty ? Center(child: Text("No Notification!", style: TextStyle(color: Colors.red, fontSize: 15.0),),) : ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: ListTile(
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.notifications_none),
            ),
            title: Text(notificationNotifier.notificationList[index].notiTitle),
            subtitle: Text(notificationNotifier.notificationList[index].notiBody),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              notificationNotifier.currentNotification = notificationNotifier.notificationList[index];
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return NotificationDetail();
              }));
            },
          ),
        );
      }, 
      itemCount: notificationNotifier.notificationList.length,
      ),
    );
  }
}
