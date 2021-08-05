import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import 'package:trainapp/logInScreen.dart';

import 'gateWay.dart';
//import 'homeScreen.dart';
import 'notifier/Auth_Notifier.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  //Timer _timer;
  //FlutterLogoStyle _logoStyle = FlutterLogoStyle.markOnly;
  double height = 150.0;
  double width = 150.0;

  // ignore: non_constant_identifier_names

  @override
  void initState() {
    super.initState();
    startTime();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
              child: Image.asset(
            'images/hmplace.png',
            height: height,
            width: width,
          )),
        ),
      ),
    );
  }

  startTime() async {
    Duration duration = Duration(seconds: 4);
    return Timer(duration, () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Consumer<AuthNotifier>(
                    builder: (context, notifier, child) {
                      return notifier.user != null ? GateWay() : LogInScreen();
                    },
                  )));
    });
  }
}
