import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/notifier/notifications_notifier.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';

class NotificationDetail extends StatefulWidget {
  @override
  _NotificationDetailState createState() => _NotificationDetailState();
}

class _NotificationDetailState extends State<NotificationDetail> {
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
          NotificationsDetailTopPart(),
          NotificationDetailBodyPart(),
        ],
      )

    );
  }
}

class NotificationsDetailTopPart extends StatefulWidget {
  @override
  _NotificationsDetailTopPartState createState() => _NotificationsDetailTopPartState();
}

class _NotificationsDetailTopPartState extends State<NotificationsDetailTopPart> {
  @override
  Widget build(BuildContext context) {
    NotificationNotifier notificationNotifier = Provider.of<NotificationNotifier>(context, listen:false);
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
              Text(notificationNotifier.currentNotification.notiTitle, 
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

class NotificationDetailBodyPart extends StatefulWidget {
  @override
  _NotificationDetailBodyPartState createState() => _NotificationDetailBodyPartState();
}

class _NotificationDetailBodyPartState extends State<NotificationDetailBodyPart> {
  @override
  Widget build(BuildContext context) {
    NotificationNotifier notificationNotifier = Provider.of<NotificationNotifier>(context, listen:false);
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Text(notificationNotifier.currentNotification.notiBody, style: TextStyle(fontSize: 24.0, fontFamily: 'Montserrat'),),
            SizedBox(height: 10.0,),
            // Text('Machine Id: '+notificationNotifier.currentNotification.machineId, style: TextStyle(fontSize: 15.0, fontFamily: 'Montserrat'),),
            SizedBox(height: 350.0,),
            Text(
              'Date: '
              +notificationNotifier.currentNotification.createdAt.toDate().day.toString()+
              '-'
              +notificationNotifier.currentNotification.createdAt.toDate().month.toString()+ 
              '-'
              +notificationNotifier.currentNotification.createdAt.toDate().year.toString(),

              style: TextStyle(
                  fontFamily: 'Montserrat'
              ),
            )
          ],
        ),
      ),
    );
  }
}