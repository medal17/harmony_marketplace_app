import 'package:flutter/material.dart';
import 'drawerScreen.dart';
import 'homeScreen.dart';
import 'logInScreen.dart';

void main() {
  runApp(MaterialApp(home: Home()),);
}

class Home extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[

          DrawerScreen(),
          HomeScreen()
        ],
      ),
    );
  }
}
