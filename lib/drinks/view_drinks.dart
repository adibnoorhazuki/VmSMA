import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/api/drink_api.dart';
import 'package:vendingapps/api/machine_api.dart';
import 'package:vendingapps/notifier/drink_notifier.dart';
import 'package:vendingapps/notifier/machine_notifier.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';
import 'package:vendingapps/drinks/add_drinks.dart';

class ViewDrinks extends StatefulWidget {

  final String mId;
  ViewDrinks([this.mId]);

  @override
  _ViewDrinksState createState() => _ViewDrinksState();
}

class _ViewDrinksState extends State<ViewDrinks> {

  @override
  void initState() {
    DrinkNotifier drinkNotifier = Provider.of<DrinkNotifier>(context, listen: false);
    getDrink(drinkNotifier, widget.mId); 
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DrinkNotifier drinkNotifier = Provider.of<DrinkNotifier>(context);
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen:false);

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
          "View Drink",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat' 
          ) 
        ),
      ),
      bottomNavigationBar: CustomAppBar(),
      resizeToAvoidBottomPadding: false,
      body: new Column(
        children: <Widget>[
          ViewDrinksTopPart(),
          DrinkListBodyPart(),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: 'button1',
            onPressed: () {
              drinkNotifier.currentDrink = null;
              String newmId = machineNotifier.currentMachine.machineId;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AddDrink(isUpdating: false, newmId : newmId);
                  }
                ),
              );
            },
            icon: Icon(Icons.add),
            backgroundColor: Colors.blue,
            label: Text("ADD DRINKS"),
          ),
        ],
      ),
    );
  }
}

class ViewDrinksTopPart extends StatefulWidget {
  @override
  _ViewDrinksTopPartState createState() => _ViewDrinksTopPartState();
}

class _ViewDrinksTopPartState extends State<ViewDrinksTopPart> {
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

class DrinkListBodyPart extends StatefulWidget {
  @override
  _DrinkListBodyPartState createState() => _DrinkListBodyPartState();
}

class _DrinkListBodyPartState extends State<DrinkListBodyPart> {
  @override
  void initState() {
    MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen: false);
    getMachine(machineNotifier);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    DrinkNotifier drinkNotifier = Provider.of<DrinkNotifier>(context);

    return Expanded(
      child: drinkNotifier.drinkList.isEmpty ? Center(child: Text("No Drink Added!", style: TextStyle(color: Colors.red, fontSize: 15.0),),) : ListView.builder(
        itemBuilder: (BuildContext context, index) {
        return Card(
          child: ListTile(
            title: Text(drinkNotifier.drinkList[index].drinkName),
            trailing: Text('Bal: '+drinkNotifier.drinkList[index].drinkQty.toString()),
            onTap: () {
            drinkNotifier.currentDrink = drinkNotifier.drinkList[index];
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return AddDrink(isUpdating: true,);
                  }
                ),
              );
            },
          ),
        );
      },
      itemCount: drinkNotifier.drinkList.length,
      ),
    );
  }
}