import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/notifier/drink_notifier.dart';
import 'package:vendingapps/models/drink.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/api/drink_api.dart';
import 'package:vendingapps/notifier/machine_notifier.dart';

class AddDrink extends StatefulWidget {

  final bool isUpdating;
  final String newmId;

  AddDrink({@required this.isUpdating, this.newmId});

  @override
  _AddDrinkState createState() => _AddDrinkState();
}

class _AddDrinkState extends State<AddDrink> {
    
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Drink _currentDrink;

  @override
  void initState(){
    super.initState();
    DrinkNotifier drinkNotifier = Provider.of<DrinkNotifier>(context, listen: false);

    if(drinkNotifier.currentDrink != null) {
      _currentDrink = drinkNotifier.currentDrink;
    } else {
      _currentDrink = Drink();
    }
  }

  Widget _buildDrinkNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Drink Name'),
      initialValue: _currentDrink.drinkName,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20.0),
      validator: (String value) {
        if(value.isEmpty) {
          return 'Drink Name is required!';
        }
        if(value.length <1 || value.length >20) {
          return 'Drink Name must be at least 1 character';
        }

        return null;
      } ,
      onSaved: (String value) {
        _currentDrink.drinkName = value;
      },
    );
  }

  Widget _buildDrinkQtyField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Drink Quantity'),
      initialValue: _currentDrink.drinkQty,
      keyboardType: TextInputType.number,
      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
      style: TextStyle(fontSize: 20.0),
      validator: (String value) {
        if(value.isEmpty) {
          return 'Drink Qty is required!';
        }
        if(value.length <1 || value.length >2) {
          return 'Drink Name must be at least 1 character';
        }

        return null;
      } ,
      onSaved: (String value) {
        _currentDrink.drinkQty = value;
      },
    );
  }

  drinkUploaded(Drink drink) {
    DrinkNotifier drinkNotifier = Provider.of<DrinkNotifier>(context, listen:false);
    drinkNotifier.addDrink(drink);
    Navigator.pop(context);
  }

  _saveDrink(context) {

    print('SaveDrink Called');
    if(!_formKey.currentState.validate()) {
      return;
    }

    Future<String> inputData() async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String uid = user.uid.toString();
      _currentDrink.userId = uid;
      _currentDrink.machineId = widget.newmId; 

      print("User ID is: $uid");
      return uid;
    }

    inputData();

    _formKey.currentState.save();

    print('drink saved');

    uploadDrink(_currentDrink, widget.isUpdating, drinkUploaded);


    print("drink Name ${_currentDrink.drinkName}");
    print("drink Qty ${_currentDrink.drinkQty}");
  }

  @override
  Widget build(BuildContext context) {
    DrinkNotifier drinkNotifier = Provider.of<DrinkNotifier>(context, listen:false);
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen: false);

    _onDrinkDeleted(Drink drink) {
      Navigator.pop(context);
      drinkNotifier.deleteDrink(drink);
    }

    return Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ), 
        backgroundColor: Colors.yellowAccent[700],
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.isUpdating ? "Edit Drink" : "Add Drink" , 
          style: TextStyle(
            fontFamily:'Montserrat',
            color: Colors.black,
            fontWeight: FontWeight.bold
          ), 
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => deleteDrink(drinkNotifier.currentDrink, _onDrinkDeleted),
            icon: Icon(Icons.delete),
            color: Colors.black,
          )
        ],
      ),
      bottomNavigationBar: CustomAppBar(),
      resizeToAvoidBottomPadding: false,
      body: Column(
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
                  Text(
                    widget.isUpdating ? machineNotifier.currentMachine.machineName : "Add Drink", 
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      fontFamily:'Pacifico',
                      fontSize: 34.0, 
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(top:0.0, left: 32.0, right: 32.0),
            child: Form(
              key: _formKey,
              autovalidate: true,
              child: Column(
                children: <Widget>[
                  _buildDrinkNameField(),
                  SizedBox(height: 10.0),
                  _buildDrinkQtyField(),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _saveDrink(context),
        icon: Icon(Icons.save),
        label: Text("SAVE"),
        foregroundColor: Colors.white,
      ),
    );
  }
}