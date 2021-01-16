import 'package:flutter/material.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';

class AboutUs extends StatelessWidget {

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
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 200.0, 
              width: 500.0,
              color: Colors.yellowAccent[700],
              child: Column(
                children: <Widget> [
                  SizedBox(height: 30.0),
                  Text('About Us', 
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
          Container(
            padding: EdgeInsets.only(top:10.0, left: 20.0, right: 20.0),
            child: Text('Vending Machine Stock Management Application (VmSMA) is an application that has been develop to ease vending machine owner to monitor and manage their vending machine in a more organize and systematic ways. Thank you to Dr Sabrina on assists me to complete this application and thank you also to UTeM because give me opportunities to develop this project.', textAlign: TextAlign.justify, style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, height: 2.0),),
          ),
          SizedBox(height: 36.0,),
          Container(
            padding: EdgeInsets.only(left:40.0, right: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  height: 150.0,
                  child: Image.asset('assets/images/google.jpg'),
                ),
                Container(
                  height: 150.0,
                  child: Image.asset('assets/images/DP.png'),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0,),
          Container(
            padding: EdgeInsets.only(left:20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('Supervisor'),

                Text('Developer'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
