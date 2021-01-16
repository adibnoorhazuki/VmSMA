import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:vendingapps/drinks/view_drinks.dart';
import 'package:vendingapps/notifier/drink_notifier.dart';
import 'package:vendingapps/notifier/machine_notifier.dart';
import 'package:vendingapps/notifier/notifications_notifier.dart';
import 'package:vendingapps/screen/about_us.dart';
import 'package:vendingapps/screen/authenticate/sign_in.dart';
import 'package:vendingapps/screen/dashboard.dart';
import 'package:vendingapps/screen/home/home.dart';
import 'package:vendingapps/screen/machine/machine_details.dart';
import 'package:vendingapps/screen/machine/machine_list.dart';
import 'package:vendingapps/screen/notifications/notifications.dart';
import 'package:vendingapps/screen/user_profile.dart';
import 'package:vendingapps/services/auth.dart';
import 'package:vendingapps/models/user.dart';

void main() => runApp(MultiProvider(
  providers: [
    ChangeNotifierProvider(
      create: (BuildContext context) => MachineNotifier(),
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) => NotificationNotifier(),
    ),
    ChangeNotifierProvider(
      create: (BuildContext context) => DrinkNotifier(),
    ),
  ],
  child: MyApp(),
));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return StreamProvider<User>.value(
      
      value: AuthService().user,
      child: MaterialApp(
        title: 'Vending Machine Stock Management Application',
        debugShowCheckedModeBanner: false,
        home: SignIn(),
        initialRoute: "/",
        routes: 
        <String, WidgetBuilder>{
          "/user_profile": (BuildContext context) => new UserProfile(),
          "/about": (BuildContext context) => new AboutUs(),
          "/notifications": (BuildContext context) => new Notifications(),
          "/dashboard": (BuildContext context) => new Dashboard(),
          "/home" : (BuildContext context) => new Home(),
          "/machine_list" : (BuildContext context) => new MachineList(),
          "/machine_details" : (BuildContext context) => new MachineDetail(),
          "/view_drink" : (BuildContext context) => new ViewDrinks(),
        }
      )
    );
  }
}

