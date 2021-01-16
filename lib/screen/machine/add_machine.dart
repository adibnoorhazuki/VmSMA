import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/api/machine_api.dart';
import 'package:vendingapps/models/machine.dart';
import 'package:vendingapps/notifier/machine_notifier.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';

class AddMachine extends StatefulWidget {

  final bool isUpdating;

  AddMachine({@required this.isUpdating});

  @override
  _AddMachineState createState() => _AddMachineState();
}

class _AddMachineState extends State<AddMachine> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Machine _currentMachine;
  String _imageUrl;
  File _imageFile;

  @override
  initState() {
    super.initState();
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen: false);

    if (machineNotifier.currentMachine != null) {
      _currentMachine = machineNotifier.currentMachine;
    } else {
      _currentMachine = Machine();
    }

    _imageUrl = _currentMachine.image;
  }

   _showImage() {
    if(_imageFile == null && _imageUrl == null) {
      return Text("Image placeholder");
    } else if(_imageFile != null) {
      print('Showing image from local file');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 300.0,
          ),
          FlatButton.icon(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            icon: Icon(Icons.camera_alt, color: Colors.white,),
            onPressed: () => _getLocalImage(), 
            label: Text(
              'Change Image',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ],
      );

    } else if(_imageUrl != null) {
      print('Showing image from URL');

      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.network(
            _imageUrl,
            fit: BoxFit.cover,
            height: 300.0,
          ),
          FlatButton.icon(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            icon: Icon(Icons.camera_alt, color: Colors.white,),
            onPressed: () => _getLocalImage(), 
            label: Text(
              'Change Image',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      );
    }
  }

  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
      maxHeight: 400,
    );

    if(imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  Widget _buildMachineNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Machine Name', 
        filled: true, 
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
           color: Colors.blue, width: 2.0, 
          )
        ),
      ),
      initialValue: _currentMachine.machineName,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20.0),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Name is Required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Name must be more than 3 and less than 20';
        }

        return null;
      },

      onSaved: (String value) {
        _currentMachine.machineName = value;
      },
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Location', 
        filled: true, 
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
           color: Colors.blue, width: 2.0, 
          ),
        ),
      ),
      initialValue: _currentMachine.machineLocation,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20.0),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Location is Required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Location must be more than 3 and less than 20';
        }

        return null;
      },

      onSaved: (String value) {
        _currentMachine.machineLocation = value;
      },
    );
  }

  _onMachineUploaded(Machine machine) {
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen: false);
    machineNotifier.addMachine(machine);
    Navigator.pop(context);
  }

  _saveMachine() {

    print('saveMachine Called');
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

    print('Form Saved');

    Future<String> inputData() async {
      final FirebaseUser user = await FirebaseAuth.instance.currentUser();
      final String uid = user.uid.toString();
       _currentMachine.userId = uid;

      print("User ID is: $uid");
      return uid;
    }

    inputData();

    uploadMachineAndImage(_currentMachine, widget.isUpdating, _imageFile, _onMachineUploaded);

    print("Machine Name: ${_currentMachine.machineName}");
    print("Location: ${_currentMachine.machineLocation}");
    print("_imageFile ${_imageFile.toString()}");
    print("ImageUrl $_imageUrl");
  }


  @override
  Widget build(BuildContext context) {
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen:false); 
    return Scaffold(
      appBar: new AppBar(
        leading: new IconButton(
        icon: new Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ), 
        backgroundColor: Colors.yellowAccent[700],
        elevation: 0.0,
        title: Text(
          widget.isUpdating ? "Edit Machine " : "Add Machine", 
          style: TextStyle(
            color: Colors.black, 
            fontWeight: FontWeight.bold, 
            fontFamily: 'Montserrat'
          ),
        ),
        centerTitle: true,
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
                  SizedBox(height: 29.0,),
                  Text(
                    widget.isUpdating ? machineNotifier.currentMachine.machineName : "Add Machine", 
                    style: TextStyle(
                      fontFamily:'Pacifico',
                      fontSize: 34.0, color: Colors.black,
                    ), 
                    textAlign: TextAlign.center,
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
                  _showImage(),
                  SizedBox(height: 16.0,),
                  Text(
                    widget.isUpdating ? "Edit Machine" : "Add New Machine", 
                    textAlign: TextAlign.center, 
                    style: TextStyle(
                      fontSize: 20.0
                    ),
                  ),
                  SizedBox(height: 16.0),
                  _imageFile == null && _imageUrl == null ?
                  ButtonTheme(
                    child: RaisedButton(
                      onPressed: () => _getLocalImage(),
                      child: Text(
                        "Add Image",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                  : SizedBox(height: 0.0,),
                    _buildMachineNameField(),
                    SizedBox(height: 10.0,),
                    _buildLocationField(),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _saveMachine(),
        icon: Icon(Icons.save),
        label: Text("SAVE"),
        foregroundColor: Colors.white,
      ),
    );
  }
}
