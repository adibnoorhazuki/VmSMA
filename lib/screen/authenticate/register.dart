import 'package:flutter/material.dart';
import 'package:vendingapps/services/auth.dart';
import 'package:vendingapps/shared/constants.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 100.0,
        child: Image.asset('assets/images/Capture.png'),
      ),
    );

    return Scaffold(
        body: Stack(
          children: <Widget> [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 100.0, horizontal: 50.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  logo,
                  SizedBox(height: 0.0),

                  RichText(
                    textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Vending Machine Stock Management Application',
                        style: TextStyle(
                          // fontWeight: FontWeight.bold, 
                          fontFamily: 'Montserrat', 
                          color: Colors.black, 
                          fontSize: 13,
                        ),
                      ),
                  ),
                  SizedBox(height:40.0),

                  RichText(
                      text: TextSpan(
                        text: 'Register',
                        style: TextStyle(
                          fontFamily:"Pacifico",
                          color: Colors.black,
                          fontSize: 32,
                        ),
                      ),
                    ),
                  SizedBox(height: 100.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter Email' : null,
                    onChanged: (val){
                      setState(() => email = val);
                    }
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    validator: (val) => val.length < 6 ? 'Enter Password 6 char long' : null,
                    onChanged: (val){
                      setState(() => password = val);
                    }
                  ),
                  SizedBox(height: 10.0),
                  RaisedButton(
                    color: Colors.blue[400],
                    child: Text(
                      'Register',
                      style: TextStyle(color:Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()){
                        setState(() => loading = true);
                        dynamic result = await _auth.registerWithEmailAndPassword(email,password);
                        if(result == null){
                          if(mounted){
                            setState(() {
                            error = 'Please enter valid email';
                            loading = false;
                          });
                          }
                        }
                      }  
                    }
                  ),
                  FlatButton(
                    child: Text(
                      "Log In",
                    ),
                    onPressed: () {
                      widget.toggleView();
                    },
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 12.0),
                  )
                ]
              ),
            )
          ),
        ),
      ]),
    );
  }
}