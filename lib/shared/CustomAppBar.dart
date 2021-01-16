import 'package:flutter/material.dart';


class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.0,
      padding: EdgeInsets.only(top: 3, bottom:30),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.timeline , size: 33.0), 
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/dashboard');
            },
          ),
          IconButton(
            icon: Icon(Icons.home, size: 33.0), 
            onPressed: (){
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle, size: 33.0), 
            onPressed: (){
              // Navigator.of(context).pop();
              Navigator.pushReplacementNamed(context, '/user_profile');
            },
          ),
        ],
      ),
    );
  }
}

