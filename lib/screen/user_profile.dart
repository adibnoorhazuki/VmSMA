import 'package:flutter/material.dart';
import 'package:vendingapps/screen/authenticate/gSignIn.dart';
import 'package:vendingapps/screen/authenticate/sign_in.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';

class UserProfile extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pushNamed("/home"),
        ), 
        backgroundColor: Colors.yellowAccent[700],
        elevation: 0.0,
        centerTitle: true,
      ),
      bottomNavigationBar: CustomAppBar(),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          UserProfileTopPart(),
          UserProfileBottomPart(),
        ],
      )
    );
  }
}

class UserProfileTopPart extends StatelessWidget {
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
              Text('User Profile', 
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

class UserProfileBottomPart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Container(
      height: 404.0,
        decoration: BoxDecoration(
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                radius: 60,
                backgroundColor: Colors.transparent,
              ),
              SizedBox(height: 40),
              Text(
                'NAME',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(height: 10.0,),
              Text(
                name,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              SizedBox(height: 10.0,),
              Text(
                email,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
              Container(
                width: 150.0,
              margin: new EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
              child: new RaisedButton(
                shape: StadiumBorder(),
                elevation: 20.0,
                color: Colors.red[600],
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return SignIn();}), ModalRoute.withName('/'));
                },
                child: Text('Log Out', style: TextStyle(color: Colors.white),), 
              ),
            ),
            ],
          ),
        ),
      );
  }
}