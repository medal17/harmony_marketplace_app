import 'package:flutter/material.dart';

import 'drawerScreen.dart';
import 'emptyScreen.dart';
import 'homeScreen.dart';

class GateWay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(//color: Colors.white,
      body: Stack(
          children: <Widget>[
            DrawerScreen(),
            EmptyScreen(),
            HomeScreen()
          ],
        ),
      )
    ;
  }
}
