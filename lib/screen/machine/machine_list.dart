import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/api/machine_api.dart';
import 'package:vendingapps/notifier/machine_notifier.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/screen/machine/add_machine.dart';
import 'package:vendingapps/screen/machine/machine_details.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';

class MachineList extends StatefulWidget {
  @override
  _MachineListState createState() => _MachineListState();
}

class _MachineListState extends State<MachineList> {

    @override
  void initState() {
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen: false);
    getMachine(machineNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context);
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
          MachineListTopPart(),
          MachineListBodyPart(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          machineNotifier.currentMachine = null;
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              return AddMachine(isUpdating: false,);
            }
          ));
        },
        icon: Icon(Icons.add),
        backgroundColor: Colors.blue,
        label: Text("ADD"),
      ),
    );
  }
}

class MachineListTopPart extends StatefulWidget {
  @override
  _MachineListTopPartState createState() => _MachineListTopPartState();
}

class _MachineListTopPartState extends State<MachineListTopPart> {
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
              Text('Vending Machine List', 
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

class MachineListBodyPart extends StatefulWidget {
  @override
  _MachineListBodyPartState createState() => _MachineListBodyPartState();
}

class _MachineListBodyPartState extends State<MachineListBodyPart> {
  @override
  void initState() {
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen: false);
    getMachine(machineNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context);
    return Expanded(
      child: machineNotifier.machineList.isEmpty ? Center(child: Text("No Machine Added!", style: TextStyle(color: Colors.red, fontSize: 15.0),),) : ListView.builder(
        itemBuilder: (BuildContext context, index) {
        return Card(
          child: ListTile(
            leading: Image.network(
              machineNotifier.machineList[index].image != null ? machineNotifier.machineList[index].image: 'https://firebasestorage.googleapis.com/v0/b/vendings-c383c.appspot.com/o/noImage.png?alt=media&token=8a85c16d-cc7a-4e93-9232-f309bb659537',
              width: 80.0,
              fit: BoxFit.fitWidth,
            ),
            title: Text(machineNotifier.machineList[index].machineName),
            subtitle: Text(machineNotifier.machineList[index].machineLocation),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {
              machineNotifier.currentMachine = machineNotifier.machineList[index];
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return MachineDetail();
              }));
            },
          ),
        );
      },
      itemCount: machineNotifier.machineList.length,
      ),
    );
  }
}