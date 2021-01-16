import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/api/machine_api.dart';
import 'package:vendingapps/drinks/view_drinks.dart';
import 'package:vendingapps/models/machine.dart';
import 'package:vendingapps/notifier/machine_notifier.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/screen/machine/add_machine.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';


class MachineDetail extends StatefulWidget { 

  @override
  _MachineDetailState createState() => _MachineDetailState();
}

class _MachineDetailState extends State<MachineDetail> {
  @override
  Widget build(BuildContext context) {
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen:false); 

    _onMachineDeleted(Machine machine) {
      Navigator.pop(context);
      machineNotifier.deleteMachine(machine);
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
          "Machine Details",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat' 
          ) 
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => deleteMachine(machineNotifier.currentMachine, _onMachineDeleted),
            icon: Icon(Icons.delete),
            color: Colors.black,
          )
        ],
      ),
      bottomNavigationBar: CustomAppBar(),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          MachineDetailTopPart(),
          MachineDetailBodyPart(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: 'button1',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AddMachine(isUpdating: true);
                  }
                ),
              );
            },
            icon: Icon(Icons.edit),
            backgroundColor: Colors.blue,
            label: Text("EDIT"),
          ),
          SizedBox(height: 10.0,),
          FloatingActionButton.extended(
            heroTag: 'button3',
            onPressed: () {
              String mId = machineNotifier.currentMachine.machineId;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ViewDrinks(mId);
                  }
                ),
              );
            },
            icon: Icon(FontAwesomeIcons.beer),
            backgroundColor: Colors.blue,
            label: Text("DRINKS"),
          ),
        ],
      ),
    );
  }
}

class MachineDetailTopPart extends StatefulWidget {
  @override
  _MachineDetailTopPartState createState() => _MachineDetailTopPartState();
}

class _MachineDetailTopPartState extends State<MachineDetailTopPart> {
  @override
  Widget build(BuildContext context) {
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen:false); 
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
              Text(machineNotifier.currentMachine.machineName,  
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

class MachineDetailBodyPart extends StatefulWidget {
  @override
  _MachineDetailBodyPartState createState() => _MachineDetailBodyPartState();
}

class _MachineDetailBodyPartState extends State<MachineDetailBodyPart> {
  @override
  Widget build(BuildContext context) {

  MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen:false); 

    _updateAt() {
      if(machineNotifier.currentMachine.updatedAt == null) {
        return Text(
          'No Data Updated!',
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.red,
              fontWeight: FontWeight.bold
          ),
        );
      }else {
        return Text(
          'Updated At: '
          +machineNotifier.currentMachine.updatedAt.toDate().day.toString()+
          '-'
          +machineNotifier.currentMachine.updatedAt.toDate().month.toString()+ 
          '-'
          +machineNotifier.currentMachine.updatedAt.toDate().year.toString(),

          style: TextStyle(
              fontFamily: 'Montserrat'
          ),
        );
      }
    }

    return Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Image.network(
                machineNotifier.currentMachine.image != null ? machineNotifier.currentMachine.image: 'https://firebasestorage.googleapis.com/v0/b/vendings-c383c.appspot.com/o/noImage.png?alt=media&token=8a85c16d-cc7a-4e93-9232-f309bb659537',
                fit: BoxFit.fitHeight,
                height: 200.0,
              ),
              SizedBox(height: 32.0,),
              Text(
                machineNotifier.currentMachine.machineName,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.0,),
              Text(
                machineNotifier.currentMachine.machineLocation,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 18.0
                ),
              ),
              SizedBox(height: 20.0,),
              Text('Created At: ' +machineNotifier.currentMachine.createdAt.toDate().day.toString()+ '-' +machineNotifier.currentMachine.createdAt.toDate().month.toString()+ '-' +machineNotifier.currentMachine.createdAt.toDate().year.toString(),
                style: TextStyle(
                  fontFamily: 'Montserrat'
                ),
              ),
              SizedBox(height: 20.0,),
              _updateAt(),
            ],
          ),
        ),
      );
  }
}