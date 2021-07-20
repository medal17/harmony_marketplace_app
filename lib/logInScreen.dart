import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trainapp/config%20file.dart';
//import 'package:trainapp/gateWay.dart';
import 'package:trainapp/signUp.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'api/Firebase_Api.dart';
import 'model/userModel.dart';
import 'notifier/Auth_Notifier.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  LocalUser _user = LocalUser();

  @override
  void initState() {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    initializeCurrentUser(authNotifier);
    super.initState();
  }

  void _submitForm() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    login(_user, authNotifier);
  }

  Widget build(BuildContext context) {
    AuthNotifier authNotifier =
        Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
        body: Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.blueGrey[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(bottom: 13),
                child: Text(
                  'Sign In',
                  style: TextStyle(
                      fontFamily: 'genuine',
                      fontWeight: FontWeight.w200,
                      fontSize: 25,
                      color: primaryGreen),
                ),
              ),
              Text(authNotifier.signInMessage.toString(),
                  style: TextStyle(
                      fontFamily: 'genuine',
                      fontWeight: FontWeight.w200,
                      color: Colors.red)),
              Container(
                height: 70,
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      height: 47,
                      width: 50,
                      child: Icon(
                        FontAwesomeIcons.user,
                        size: 17,
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          //obscureText: true,
                          //keyboardType: Keyboar,
                          decoration: InputDecoration(
                            hintText: 'Username',
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Input your Username';
                            }
                            if (value.length < 5) {
                              return 'Username must be between 5 and 12';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _user.email = value;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: 70,
                // padding: EdgeInsets.only(bottom: 5),
                padding: EdgeInsets.symmetric(vertical: 8),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: primaryGreen,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10))),
                      height: 50,
                      width: 50,
                      child: Icon(
                        FontAwesomeIcons.key,
                        size: 17,
                        color: Colors.white70,
                      ),
                    ),
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: TextFormField(
                          style: TextStyle(fontSize: 14),
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Input your Password';
                            }
                            if (value.length < 5 || value.length > 12) {
                              return 'Password must be between 5 and 12';
                            }
                            return null;
                          },
                          onSaved: (String value) {
                            _user.password = value;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  _submitForm();
                  authNotifier.setSignInStatus(true);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 90),
                  child: authNotifier.signInStatus
                      ? SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'genuine',
                              fontSize: 20),
                        ),
                  decoration: BoxDecoration(
                      color: primaryGreen,
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => SignUpScreen()));
                },
                child: Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 60),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'genuine',
                        fontSize: 20),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
