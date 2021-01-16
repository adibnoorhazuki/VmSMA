import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/api/machine_api.dart';
import 'package:vendingapps/notifier/machine_notifier.dart';
import 'package:vendingapps/screen/authenticate/gSignIn.dart';
import 'package:vendingapps/screen/authenticate/sign_in.dart';
import 'package:vendingapps/screen/home/CustomShapeClipper.dart';
import 'package:vendingapps/screen/machine/machine_details.dart';
import 'package:vendingapps/shared/CustomAppBar.dart';


ThemeData appTheme = 
  ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'Oxygen');

class Home extends StatelessWidget {
 final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    // final GoogleSignIn _gSignIn = GoogleSignIn();

    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.yellowAccent[700],
        centerTitle: true,
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.dehaze),
          color: Colors.black,
          onPressed: () {
            _scaffoldKey.currentState.openDrawer();
          },
        ),
      ),
      bottomNavigationBar: CustomAppBar(),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          HomeSceenTopPart(),
          HomeScreenBottomPart(),
          BottomButton(),
          CopyRight(),
        ],
      ),
    );
  }
}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            Container(
              height: 180.0,
              child: new UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.yellowAccent[700],
                ),
                accountName: new Text(
                  name, 
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 24.0,
                    fontFamily: 'Montserrat'
                  ),
                ), 
                accountEmail: new Text(
                  email, 
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Montserrat'
                  ),
                ),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
            ),
            
//----------------------------------------------------------------------------------

            CustomListTile(Icons.person,'Profile', () => {
              Navigator.of(context).pop(),
              Navigator.of(context).pushNamed("/user_profile")
            },),

//-----------------------------------------------------------------------------------

            CustomListTile(Icons.timeline,'Dashboard', ()=>{
              Navigator.of(context).pop(),
              Navigator.of(context).pushNamed("/dashboard")
            },),

//-----------------------------------------------------------------------------------

            CustomListTile(Icons.error,'About Us', ()=>{
              Navigator.of(context).pop(),
              Navigator.of(context).pushNamed("/about")
            },),

//-----------------------------------------------------------------------------------



            SizedBox(height: 395.0,),
            Container(
              margin: new EdgeInsets.fromLTRB(70.0, 10.0, 70.0, 10.0),
              child: new RaisedButton.icon(
                shape: StadiumBorder(),
                // elevation: 2.0,
                color: Colors.redAccent[700],
                onPressed: () {
                  signOutGoogle();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) {return SignIn();}), ModalRoute.withName('/'));
                },
                label: Text('Log Out', style: TextStyle(color: Colors.white),), 
                icon: Icon(Icons.exit_to_app, color: Colors.white,),
              ),
            ),
          ],
        ),
      );
  }
}

  class CustomListTile extends StatelessWidget {

    final IconData icon;
    final String text;
    final Function onTap;

    CustomListTile(this.icon,this.text,this.onTap);

    @override
    Widget build(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(8.0,0,10.0,5.0),
        child: Container(
          // decoration: BoxDecoration(
          //   border: Border(bottom: BorderSide(color: Colors.grey.shade400))
          // ),
          child: InkWell(
            splashColor: Colors.grey[700],
            onTap: onTap,
            child: Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget> [
                  Row(
                    children: <Widget>[
                      Icon(icon),
                      Padding(padding: const EdgeInsets.all(20.0),
                      child: Text(
                        text, 
                        style: TextStyle( 
                          fontSize: 16.0,
                      ),),
                      ),
                    ],
                  ),
                //  Icon(Icons.arrow_right),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  class HomeSceenTopPart extends StatelessWidget {

    @override
    Widget build(BuildContext context) {
      return 
      Stack(
        children: <Widget>[
          ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: 238.0, 
              width: 500.0,
              color: Colors.yellowAccent[700],
              child: Column(
                children: <Widget> [
                  Text('Welcome ', 
                  style: TextStyle(
                    fontFamily:'Pacifico',
                    fontSize: 30.0, 
                    color: Colors.black, 
                  ), 
                  textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text(name, 
                  style: TextStyle(
                    fontFamily:'Satisfy',
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold, 
                    color: Colors.redAccent[700], 
                  ), 
                  textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10.0),
                  Text('To Vending Machine Apps', 
                  style: TextStyle(
                    fontFamily:'Pacifico',
                    fontSize: 30.0, 
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

  var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);

  class HomeScreenBottomPart extends StatefulWidget {
    @override
    _HomeScreenBottomPartState createState() => _HomeScreenBottomPartState();
  }
  
  class _HomeScreenBottomPartState extends State<HomeScreenBottomPart> {

    @override
    void initState() {
      MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context, listen: false);
      getMachine(machineNotifier);
      super.initState();
    }
  
    @override
    Widget build(BuildContext context) {
      MachineNotifier machineNotifier = Provider.of<MachineNotifier>(context);
      return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget> [
                Text(
                  'List Of Machines', 
                  style: TextStyle(
                    fontFamily:'Montserrat',
                    color: Colors.black, 
                    fontSize: 16.0
                  ), 
                ),
                Spacer(),
                InkWell(
                  child: Text(
                    "VIEW ALL(...)", style: TextStyle(fontFamily: 'Montserrat',color: Colors.red, fontSize: 12.0),
                  ),
                  onTap: () => {
                    Navigator.of(context).pushNamed("/machine_list"),
                  },
                ),
              ],
            ),
          ),
          SizedBox(height:20.0),
          Container(
            height: 260.0,
            child: machineNotifier.machineList.isEmpty ? Center(child: Text("No Machine Added!", style: TextStyle(color: Colors.red, fontSize: 15.0),),) : ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext context, index) {
                return GestureDetector(
                  onTap: () {
                    machineNotifier.currentMachine = machineNotifier.machineList[index];
                    Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                      return MachineDetail();
                    }));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.0)
                      ),
                      child: Stack(
                        children: <Widget> [
                          Container(
                            height: 290.0,
                            width: 160.0,
                            child: Image.network(
                              machineNotifier.machineList[index].image != null ? machineNotifier.machineList[index].image: 'https://firebasestorage.googleapis.com/v0/b/vendings-c383c.appspot.com/o/noImage.png?alt=media&token=8a85c16d-cc7a-4e93-9232-f309bb659537',                            
                              fit: BoxFit.cover,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              border: new Border.all( 
                              color: Colors.black,
                              width: 3.0,
                              style: BorderStyle.solid,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: machineNotifier.machineList.length,
            ),
          ),
          SizedBox(height: 30.0)
        ],
      );
    }
  }

class BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          margin: new EdgeInsets.fromLTRB(20.0, 10.0, 0.0, 10.0),
          child: new RaisedButton.icon(
            color: Colors.yellowAccent[700],
            onPressed: () {
              Navigator.pushNamed(context, "/dashboard");
            }, 
            icon: Icon(Icons.timeline), 
            label: Text('Dashboard'), 
          ),
        ),
        
        Spacer(),
        // Container(
        //   // margin: new EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
        //   child: new RaisedButton.icon(
        //     color: Colors.yellowAccent[700],
        //     onPressed: () {
        //       Navigator.pushNamed(context, '/notifications');
        //     }, 
        //     icon: Icon(Icons.notifications_active), 
        //     label: Text('Notification'), 
        //   ),
        // ),
        // Spacer(),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          margin: new EdgeInsets.fromLTRB(0.0, 10.0, 20.0, 10.0),
          child: new RaisedButton.icon(
            color: Colors.yellowAccent[700],
            onPressed: () {
              Navigator.pushNamed(context, '/machine_list');
            }, 
            icon: Icon(Icons.list), 
            label: Text('Machine'), 
          ),
        ),
      ],
    );
  }
}

class CopyRight extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
        child: Text("2020 \u00a9 PSM Adib Hazuki"),
      ),
    );
  }
}


