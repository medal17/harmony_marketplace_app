import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/config%20file.dart';
//import 'package:trainapp/logInScreen.dart';
import 'package:trainapp/signUp.dart';

import 'api/Firebase_Api.dart';
import 'notifier/Auth_Notifier.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Container(
      color: primaryGreen,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(),
                SizedBox(
                  width: 18,
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        authNotifier.user != null
                            ? authNotifier.user.email
                            : "Sign in",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'genuine',
                            fontSize: 20,
                            fontWeight: FontWeight.w100),
                      ),
                      Text(
                        'Status: Active',
                        style: TextStyle(
                            color: Colors.blueGrey[400],
                            fontWeight: FontWeight.w800,
                            fontSize: 15),
                      )
                    ],
                  ),
                )
              ],
            ),
            Expanded(
                child: Container(
              margin: EdgeInsets.symmetric(vertical: 90),
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: drawerMenu
                    .map(
                      (element) => GestureDetector(
                        onTap: () {
                          print(element["title"]);
                          navigate(context, element["title"]);
                        },
                        child: Row(
                          children: <Widget>[
                            Icon(
                              element['icon'],
                              color: Colors.blueGrey[400],
                              size: 20,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(element['title'],
                                style: TextStyle(
                                  color: Colors.blueGrey[300],
                                  fontWeight: FontWeight.w200,
                                  fontSize: 16,
                                  fontFamily: 'genuine',
                                )),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            )),
            Row(
              children: <Widget>[
                /*Icon(
                  Icons.settings,
                  color: Colors.blueGrey[400],
                ),
                SizedBox(
                  width: 15,
                ),
                Text('Settings',
                    style: TextStyle(
                        color: Colors.blueGrey[400],
                        fontWeight: FontWeight.w500,
                        fontSize: 19)),
                SizedBox(
                  width: 30,
                ),*/
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SignUpScreen()));
                  },
                  child: Icon(
                    Icons.power_settings_new,
                    color: Colors.blueGrey[400],
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                GestureDetector(
                  onTap: () {
                    signout(authNotifier);
                  },
                  child: Text('Logout',
                      style: TextStyle(
                        color: Colors.blueGrey[300],
                        fontWeight: FontWeight.w200,
                        fontSize: 19,
                        fontFamily: 'genuine',
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
