import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';

String tDrink;
String tMachine;
  totalDrink() async {
    
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String currUID = user.uid.toString();
    
    QuerySnapshot _myDoc = await Firestore.instance.collection('drink').where('userId', isEqualTo: currUID).getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    tDrink = _myDocCount.length.toString();
    print(_myDocCount.length);  // Count of Documents in Collection
  }

  totalMachine() async {
    
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    final String currUID = user.uid.toString();
    
    QuerySnapshot _myDoc = await Firestore.instance.collection('machine').where('userId', isEqualTo: currUID).getDocuments();
    List<DocumentSnapshot> _myDocCount = _myDoc.documents;
    tMachine = _myDocCount.length.toString();
    print(_myDocCount.length);  // Count of Documents in Collection
  }

void main() => runApp(Dashboard());

class Dashboard extends StatelessWidget {

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
        centerTitle: true,
      ),
      bottomNavigationBar: CustomAppBar(),
      resizeToAvoidBottomPadding: false,
      body: new Column(
        children: <Widget>[
          DashboardTopPart(),
          DashboardBottomPart(),
        ],
      ),
    );
  }
}

class DashboardTopPart extends StatefulWidget {
  @override
  _DashboardTopPartState createState() => _DashboardTopPartState();
}

class _DashboardTopPartState extends State<DashboardTopPart> {
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
              Text('Dashboard', 
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

class DashboardBottomPart extends StatelessWidget {

   
  @override
  Widget build(BuildContext context) {
    totalDrink();
    totalMachine();
    return _myListView(context);
  }
}

    // replace this function with the code in the examples
    Widget _myListView(BuildContext context) {
      return Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(bottom: 15),
            alignment: Alignment(-0.88, 0.0), 
            child: Text(
              "Sales Activity", 
              textAlign: TextAlign.left, 
              style: TextStyle(
                fontSize: 20.0, 
                fontFamily: "Montserrat", 
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            height: 100.0,
            width: 400.0,
            child: new Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListTile(
                    title: Text("Total Product ", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),),
                    trailing: Text(tDrink),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5),
            height: 100.0,
            width: 400.0,
            child: new Card(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new ListTile(
                    title: Text("Total Machines", style: TextStyle(fontSize: 19.0, fontWeight: FontWeight.bold),),
                    trailing: Text(tMachine),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    